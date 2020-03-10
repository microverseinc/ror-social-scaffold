require 'rails_helper'

RSpec.describe 'Posts controller tests', type: :feature do
  let(:test_user) { User.new(name: 'test user', email: 'test@user.com',
                             password: 'password', password_confirmation: 'password') }
  let(:test_user_2) { User.new(name: 'test user 2', email: 'test@user2.com',
                               password: 'password', password_confirmation: 'password') }
  let(:test_user_3) { User.new(name: 'test user 3', email: 'test@user3.com',
                               password: 'password', password_confirmation: 'password')}
  let(:test_friendship) { Friendship.new(user_id: test_user.id, friend_id: test_user_3.id, confirmed: true) }
  let(:test_post) { Post.new(user_id: test_user.id, content: 'Hello world!') }
  let(:test_post_2) { Post.new(user_id: test_user_3.id, content: "I'm user 2") }

  def store_in_database
    test_user.save
    test_user_2.save
    test_user_3.save
    test_friendship.save
    test_post.save
    test_post_2.save
  end

  def log_in
    visit root_url
    fill_in 'Email', with: test_user.email
    fill_in 'Password', with: test_user.password
    click_button 'Log in'
  end

  scenario 'Timeline displays comments from the user' do
    store_in_database
    log_in
    expect(page).to have_selector 'p', text: 'Hello world!'
  end

  scenario "Timeline shows the comment from the user's friend" do
    store_in_database
    log_in
    expect(page).to have_selector 'p', text: "I'm user 2"
  end

  scenario "Comment is succesfully created" do
    store_in_database
    log_in
    within("li#post-#{test_post_2.id}"){fill_in 'comment_content', with: 'test'}
    within("li#post-#{test_post_2.id}"){click_button 'Comment'}
    expect(page).to have_selector 'p', text: 'test'
  end

  scenario "Comment counter works" do
    store_in_database
    log_in
    within("li#post-#{test_post_2.id}"){fill_in 'comment_content', with: 'test'}
    within("li#post-#{test_post_2.id}"){click_button 'Comment'}
    within("li#post-#{test_post_2.id}"){expect(page).to have_selector 'div.post-liking', text: '1 comment'}
  end

  scenario "Like counter works" do
    store_in_database
    log_in
    within("li#post-#{test_post_2.id}"){click_link 'Like!'}
    within("li#post-#{test_post_2.id}"){expect(page).to have_selector 'div.post-liking', text: '1 like'}
  end
end