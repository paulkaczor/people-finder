module AlchemyApi
  NamedEntityExtractionResult = Struct.new(:type, :relevance, :count, :text)
  NamedEntity = Struct.new(:text, :type, :relevance)

  class NamedEntityExtraction < Base
    post(:get_ranked_namedentities_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetRankedNamedEntities"
      params :html => html,
             :url => options[:url],
             :maxRetrieve => options[:max_retrieve] || 10,
             :outputMode => options[:output_mode] || 'json',
             :quotations => options[:quotations] ? 1 : 0,
             :showSourceText => options[:show_source_text] ? 1 : 0,
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::NamedEntityExtraction.get_ranked_namedentities_handler(response)
      end
    end

    post(:get_ranked_namedentities_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetRankedNamedEntities"
      params :url => url,
             :maxRetrieve => options[:max_retrieve] || 10,
             :outputMode => options[:output_mode] || 'json',
             :quotations => options[:quotations] ? 1 : 0,
             :showSourceText => options[:show_source_text] ? 1 : 0,
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::NamedEntityExtraction.get_ranked_namedentities_handler(response)
      end
    end

    post(:get_ranked_namedentities_from_text) do |text, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_text_uri}/TextGetRankedNamedEntities"
      params :text => text,
             :url => options[:url],
             :maxRetrieve => options[:max_retrieve] || 10,
             :outputMode => options[:output_mode] || 'json',
             :quotations => options[:quotations] ? 1 : 0,
             :showSourceText => options[:show_source_text] ? 1 : 0
      handler do |response|
        AlchemyApi::NamedEntityExtraction.get_ranked_namedentities_handler(response)
      end
    end

    def self.get_ranked_namedentities_handler(response)
      json = get_json(response)
      namedentity = json['namedentity'].map do |ne|
        NamedEntity.new(ne['text'], ne['type'], ne['relevance'].to_f)
      end
      NamedEntityExtractionResult.new(json['type'], json['relevance'],
                               json['count'], json['text'])
    end
  end
end
