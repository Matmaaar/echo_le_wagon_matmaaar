class ContentSummarizer
  def initialize(transcription:, language:)
    # Si transcription est un tableau (comme renvoyé par SupaData), on reconstruit le texte.
    @transcription = if transcription.is_a?(Array)
      transcription.map { |seg| seg["text"] }.join(" ")

    else
      transcription
    end

    @language = language
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  def call
    prompt = <<~PROMPT
      You are a university professor who is an expert in the subject discussed in the transcription below. Based on this raw transcription, generate a **structured, detailed, and pedagogical course** intended for master's level students.

    ### 🎯 Objective:
    Produce faithful and comprehensive course material from the transcription, without adding external information except to clarify or supplement unclear parts. Each concept must be explained clearly, thoroughly, and pedagogically, as in a real course. The content should allow for in-depth review and make it easy to find all explanations and information covered in the video. It should not be too short, as it represents the essential content.

    ### 🖥️ Output format:
    - Language: **HTML only** (no text outside HTML tags)
    - Do not use markdown tags
    - Expected structure:
      - <h1>Title</h1>
      - <h2>Section title</h2>
      - <h3>Subsection</h3> (obligatory for subsections)
      - <p>Detailed, developed and faithful pedagogical content, with examples if present in the transcription</p>
      - For emphasis: wrap any key idea or concept in `<strong>important word or information</strong>`

    - Special blocks (pedagogical boxes):
      Integrate special blocks when pedagogically relevant, depending on their nature:
      - **Tip**: for sharing a useful piece of advice to learn or apply a concept
        - Use the tag: `<div class="tip">`
      - **Warning**: to highlight a frequent mistake, exception, or critical point
        - Use the tag: `<div class="warning">`
      - **Frequently Asked Question**: to answer a common question on the topic
        - Use the tag: `<div class="faq">`

    > ❗️**Do not include the labels "Tip", "Warning", or "Frequently Asked Question" in the HTML content.**
    > These titles are automatically rendered through the SCSS styles of each class.

    - End the document with a glossary containing all glossary terms:
      - <h3>Glossary</h3>
      - <ul><li><strong class="important-term">Term</strong>: Short and clear definition</li></ul>

    ### 📏 Length:
    The summary should **not over-condense** the content. Aim for approximately **1 line of summary for every 2 to 3 lines** of transcription.
    Example: for a 300-line transcription, the HTML summary should contain **about 150 to 200 lines**.

    ### 🚫 Strict guidelines:
    - Never mention the video, its author, the platform, jokes, music, or intro/outro.
    - The summary must be in #{@language}.
    - Do not write a global summary; develop each point raised in the transcription.
    - Do not write a conclusion at the end; the content must be self-contained.
    - Expand all mentioned ideas with clear, precise, and pedagogical explanations.
    - No personal opinions, comments, or meta-discourse.
    - If there are commercial collaborations, advertisements, or partnerships, do not mention them.
    - **Do not write the titles "Tip", "Warning", or "Frequently Asked Question" inside the HTML blocks.**

    Here is the transcription to analyze:

      #{@transcription}
        PROMPT

    response = @client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [
          { role: "system", content: "Tu es un assistant qui produit des résumés clairs et fidèles à la transcription." },
          { role: "user", content: prompt }
        ],
        temperature: 0.7
      }
    )

    response.dig("choices", 0, "message", "content")&.strip
  rescue => e
    Rails.logger.error("Erreur dans ContentSummarizer : #{e.message}")
    nil
  end
end
