extends Control


@onready var status_label: RichTextLabel = $Status
@onready var url_field: LineEdit = $URL_Field
@onready var download_field: LineEdit = $Download_Field

var is_everything_ready : bool = false

func  _init() -> void:
	if not YtDlp.is_setup():
		YtDlp.setup()
		await  YtDlp.setup_completed
		status_label.text = "Status: [color=green]READY[/color]"
		

func _process(delta: float) -> void:
	if YtDlp.is_setup():
		print("Ready to go")
	else:
		print("Hold on")
