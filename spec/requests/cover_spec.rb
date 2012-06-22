require 'carrierwave/test/matchers'

describe CoverUploader do
  include CarrierWave::Test::Matchers

  let!(:album) {FactoryGirl.create :album }

  before do
    CoverUploader.enable_processing = true
    @uploader = CoverUploader.new(album, :cover)
    @uploader.store!(File.open("#{Rails.root}/spec/fixtures/rails.jpg"))
  end

  after do
    CoverUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumb version' do
    it "should scale down a cover image to be no more than 50 by 50 pixels" do
      @uploader.thumb.should be_no_larger_than(50, 50)
    end
  end

  context 'the big version' do
    it "should scale down a cover image to be no more than 200 by 200 pixels" do
      @uploader.big.should be_no_larger_than(200, 200)
    end
  end

end