require File.dirname(__FILE__) + "/../spec_helper"

describe AlchemyApi::NamedEntityExtraction do
  shared_examples_for 'a entity ranker' do
    it "should return source text" do
      @result.source_text.should_not be_nil
    end

    it "should return" do
      @result.namedentities.should have(10).things
    end

    it "should have relevance scores for the entities" do
      @result.namedentities.each do |ne|
        ne.relevance.should >= 0.0
        ne.relevance.should <= 1.0
      end
    end
  end

  typhoeus_spec_cache('spec/cache/namedentity_extraction/get_ranked_namedentities_from_html') do |hydra|
    describe "#get_ranked_namedentities_from_html" do
      before(:each) do
        @url = "http://www.businessweek.com/news/2010-04-29/bp-spill-may-alter-obama-s-offshore-drilling-plans-update1-.html"
        @html = fixture_for('bp_spill.html')
        @result = AlchemyApi::NamedEntityExtraction.
          get_ranked_namedentities_from_html(@html,
                                        :url => @url,
                                        :max_retrieve => 10,
                                        :show_source_text => true)
      end

      it_should_behave_like 'a entity ranker'
    end
  end

  typhoeus_spec_cache('spec/cache/namedentity_extraction/get_ranked_namedentities_from_text') do |hydra|
    describe "#get_ranked_namedentities_from_text" do
      before(:each) do
        @url = "http://test.com"
        text = fixture_for('article.txt')
        @result = AlchemyApi::NamedEntityExtraction.
          get_ranked_namedentities_from_text(text,
                                        :url => @url,
                                        :max_retrieve => 10,
                                        :show_source_text => true)
      end

      it_should_behave_like 'a entity ranker'
    end
  end

  typhoeus_spec_cache('spec/cache/namedentity_extraction/get_ranked_namedentities_from_url') do |hydra|
    describe "#get_ranked_namedentities_from_url" do
      before(:each) do
        @url = 'http://www.businessweek.com/news/2010-05-02/bp-spill-threatens-gulf-of-mexico-oil-gas-operations-update1-.html'
        @result = AlchemyApi::NamedEntityExtraction.
          get_ranked_namedentities_from_url(@url,
                                       :max_retrieve => 10,
                                       :show_source_text => true)
      end

      it "should return the given URL" do
        @result.url.should == @url
      end

      it_should_behave_like 'a entity ranker'
    end
  end
end
