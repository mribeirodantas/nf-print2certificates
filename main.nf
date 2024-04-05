process FOO {
  container 'mribeirodantas/print2certificates:latest'
  publishDir 'output', mode: 'copy'

  input:
  val participant_name
  tuple val(x), val(y)
  path font
  path template

  output:
  path "${participant_name.replace(" ", "")}.png"

  script:
  """
  #!/usr/local/bin/python3

  from PIL import Image, ImageFont, ImageDraw

  FONT_FILE = ImageFont.truetype(r'GochiHand-Regular.ttf', 100)
  FONT_COLOR = "#000000"
  WIDTH, HEIGHT = ${x}, ${y}


  def make_cert(name):
      image_source = Image.open(r'certificate_template.png')
      draw = ImageDraw.Draw(image_source)
      name_width, name_height = draw.textsize(name, font=FONT_FILE)
      draw.text((WIDTH-name_width/2, HEIGHT-name_height/2), name, fill=FONT_COLOR, font=FONT_FILE)
      image_source.save(name.replace(" ", "") + ".png")
      print('printing certificate of: '+name)

  make_cert('${participant_name.replace("'", "\\'")}')
  """
}

workflow {
  Channel
    .fromPath(params.names)
    .splitText { it.trim() }
    .set { participant_names }
  FOO(participant_names,
      Channel.of([params.x, params.y]).first(),
      Channel.fromPath(params.font).first(),
      Channel.fromPath(params.template).first())
}
