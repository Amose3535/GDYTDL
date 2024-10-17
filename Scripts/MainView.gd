extends Control


@onready var status_label: RichTextLabel = $Status
@onready var url_field: LineEdit = $URL_Field
@onready var download_field: LineEdit = $Download_Field
@onready var download_name: LineEdit = $Download_Name
@onready var video_download_button: Button = $Video_Download
@onready var audio_download_button: Button = $Audio_Download



var is_everything_ready : bool = false
var download

func  _ready() -> void:
	video_download_button.disabled = true
	audio_download_button.disabled = true
	if not YtDlp.is_setup():
		YtDlp.setup()
		await  YtDlp.setup_completed
		status_label.text = "Status: [color=green]READY[/color]"
		video_download_button.disabled = false
		audio_download_button.disabled = false

func _on_video_download_pressed() -> void:
	video_download_button.disabled = true
	audio_download_button.disabled = true
	download = YtDlp.download(url_field.text).set_destination(download_field.text).set_file_name(download_name.text).start()
	assert(download.get_status() == YtDlp.Download.Status.DOWNLOADING)
	status_label.text = "Status: [color=orange]Downlaoding[/color]"
	await download.download_completed
	status_label.text = "Status: [color=green]Done[/color]"
	
	
