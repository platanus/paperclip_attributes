require "rails_helper"

RSpec.describe User, type: :model do
  describe "attributes" do
    context "working with images" do
      def expect_initial_state
        expect(@user.avatar_width).to be_nil
        expect(@user.avatar_height).to be_nil
        expect(@user.avatar_dominant_color).to be_nil
      end

      before { @user = User.new(avatar: fixture_file_upload("bukowski.jpg", "image/png")) }

      it "has nil initial state" do
        expect_initial_state
      end

      context "saving instance" do
        before do
          @user.name = "Leandro"
          @user.save
        end

        it "copies image related attributes on model" do
          expect(@user.avatar_width).to eq(600)
          expect(@user.avatar_height).to eq(794)
          expect(@user.avatar_dominant_color).to eq("#9d9a8f")
        end

        context "changing image" do
          before do
            @user.avatar = fixture_file_upload("pikachu.png", "image/png")
            @user.save
          end

          it "recalculates values after change image" do
            expect(@user.avatar_width).to eq(249)
            expect(@user.avatar_height).to eq(307)
            expect(@user.avatar_dominant_color).to eq("#fffd76")
          end
        end
      end

      context "with validation errors" do
        before { @user.save }

        it "does not save new attributes" do
          expect_initial_state
        end
      end
    end
  end
end
