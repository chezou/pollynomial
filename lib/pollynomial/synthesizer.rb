require 'aws-sdk'

module Pollynomial
  class Synthesizer
    POLLY_TEXT_LIMIT_SIZE = 1500
    DEFAULT_DELIMITER = '[.。]'
    COMMA = '[,、]'

    def initialize(region: 'us-east-1', voice_id: "Joanna", delimiter: DEFAULT_DELIMITER, comma: COMMA)
      @polly = Aws::Polly::Client.new(region: region)
      @delimiter = delimiter
      # You can use voice IDs http://docs.aws.amazon.com/polly/latest/dg/API_Voice.html
      # If you want to synthesize Japanese voice, you can use "Mizuki"
      @voice_id = voice_id
      @comma = COMMA
    end

    def synthesize(text, file_name: "tmp.mp3")
      File.delete(file_name) if File.exist?(file_name)
      File.open(file_name, 'ab') do |file|
        split_text(text).each do |_text|
          tmp_file = Tempfile.new
          @polly.synthesize_speech(
            response_target: tmp_file,
            text: _text,
            output_format: "mp3",
            voice_id: @voice_id
            )
          IO.copy_stream(tmp_file, file)
          sleep(1)
        end
      end
    end

    def available_voices_in(language_code: 'en-US')
      voices = @polly.describe_voices(language_code: language_code)
      voices.voices if voices
    end

    def split_text(raw_text)
      combined_texts = []
      tmp_string = ""
      raw_text.split(/\n|(?<=#{@delimiter}) ?/).each do |text|
        if tmp_string.size + text.size > POLLY_TEXT_LIMIT_SIZE
          if tmp_string.size > POLLY_TEXT_LIMIT_SIZE
            combined_texts << tmp_string.split(/(?<=#{@comma})/)
          else
            combined_texts << tmp_string
          end
          tmp_string = text
        else
          tmp_string << " #{text}"
        end
      end
      combined_texts << tmp_string.lstrip
      combined_texts.flatten!
      combined_texts
    end
  end
end
