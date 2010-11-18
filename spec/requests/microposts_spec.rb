require 'spec_helper'
require 'faker'

describe "Microposts" do
  
  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end
  
  describe "creation" do
    
    describe "failure" do
      
      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Micropost, :count)
      end
    
    end
    
    describe "success" do
      
      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
        end.should change(Micropost, :count).by(1)
      end
      
    end
  
  end
  
  describe "count" do
    
    before(:each) do
      @count = @user.microposts.count
    end
    
    it "should be displayed on the home page" do
      visit root_path
      response.should have_selector("span.microposts", :content => "#{@count}")
    end
    
    it "should be displayed on the user's profile" do
      visit user_path(@user)
      response.should have_selector("span.microposts", :content => "#{@count}")
    end
    
  end
    
  describe "feed for current user" do
  
    before(:each) do
      @mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
      @mp2 = Factory(:micropost, :user => @user, :content => "Baz quux")
    end
    
    it "should be displayed on the home page" do
      visit root_path
      response.should have_selector("span.content", :content => @mp1.content)
      response.should have_selector("span.content", :content => @mp2.content)
    end
    
    it "should be paginated on the home page" do
      @microposts = [@mp1, @mp2]
      30.times do
        @microposts << Factory(:micropost,
                               :user => @user,
                               :content => Faker::Lorem.sentence(5))
      end
      visit root_path
      response.should have_selector("div.pagination")
      response.should have_selector("span.disabled", :content => "Previous")
      response.should have_selector("a", :href => "/?page=2",
                                         :content => "2")
      response.should have_selector("a", :href => "/?page=2",
                                         :content => "Next")
    end
    
  end
  
end
