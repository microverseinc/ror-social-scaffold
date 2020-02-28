require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  include Integration
  before(:each) do
    create_initial_conditions
    create_posts
  end
  it 'Does not create comment' do
    first(:button, 'Comment').click
    expect(page).to have_content("Content can't be blank")
  end

  it 'Does not create comment with too long content' do
    page.all(:fillable_field, 'comment[content]').first.set('*' * 201)
    first(:button, 'Comment').click
    expect(page).to have_content('Content 200 characters in comment is the maximum allowed.')
  end

  it 'Create comment' do
    page.all(:fillable_field, 'comment[content]').first.set('This is a new comment')
    first(:button, 'Comment').click
    expect(page).to have_content('Comment was successfully created.')
    expect(find_all('.post-comments').count).to eq(1)
  end
end
