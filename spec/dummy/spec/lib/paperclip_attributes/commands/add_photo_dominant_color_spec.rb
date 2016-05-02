require "rails_helper"

RSpec.describe PaperclipAttributes::Commands::AddPhotoDominantColor do
  describe "#perform" do
    context "with image content type" do
      before do
        @user = User.new(avatar: fixture_file_upload("bukowski.jpg", "image/png"))
        described_class.new(@user, :avatar).perform
      end

      it "adds image dominant color to model" do
        expect(@user.avatar_dominant_color).to eq("#9d9a8f")
      end
    end

    context "with non image content type" do
      before do
        @user = User.new(avatar: fixture_file_upload("video.mp4", "video/mp4"))
        described_class.new(@user, :avatar).perform
      end

      it "does not save image dominant color" do
        expect(@user.avatar_dominant_color).to be_nil
      end
    end
  end
end
