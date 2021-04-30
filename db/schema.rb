# rubocop:disable Metrics/BlockLength

ActiveRecord::Schema.define(version: 20_210_429_033_011) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'comments', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'post_id'
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_comments_on_post_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'friendships', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'friend_id'
    t.string 'status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['friend_id'], name: 'index_friendships_on_friend_id'
    t.index ['user_id'], name: 'index_friendships_on_user_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.integer 'post_id'
    t.integer 'user_id'
    t.index ['post_id'], name: 'index_likes_on_post_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.integer 'user_id'
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.string 'gravatar_url'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'friendships', 'users'
  add_foreign_key 'friendships', 'users', column: 'friend_id'
end
# rubocop:enable Metrics/BlockLength
