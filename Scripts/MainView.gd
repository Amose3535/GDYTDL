extends Control
@onready var status_label: RichTextLabel = $Status
@onready var url_field: LineEdit = $URL_Field
@onready var download_field: LineEdit = $Download_Field
@onready var download_name: LineEdit = $Download_Name
@onready var video_download_button: Button = $Video_Download
@onready var audio_download_button: Button = $Audio_Download

var download = null
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
	# Download video function

	# Disable buttons to prevent multiple downloads
	video_download_button.disabled = true
	audio_download_button.disabled = true
	# Start download
	download = YtDlp.download(url_field.text).set_destination(download_field.text).set_file_name(download_name.text).start()
	# Assert that the download is in progress, if not then the download failed (function will stop)
	if download.get_status() != YtDlp.Download.Status.DOWNLOADING:
		status_label.text = "Status: [color=red]Download failed[/color]"
		return
	else:
		# set the status label to downloading
		status_label.text = "Status: [color=orange]Downlaoding[/color]"
		# Wait for the download to complete
		await download.download_completed
		# Set the status label to done after the download is completed
		status_label.text = "Status: [color=green]Done[/color]"
		# Enable the buttons after the download is completed
		video_download_button.disabled = false
		audio_download_button.disabled = false
	
	
