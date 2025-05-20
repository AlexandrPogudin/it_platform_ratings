require "google/cloud/translate"

class GoogleTranslateService
  def initialize
    @translate = Google::Cloud::Translate.translation_v2_service
  end

  def translate(text, target_language)
    translation = @translate.translate text, to: target_language
    translation.text
  end
end
