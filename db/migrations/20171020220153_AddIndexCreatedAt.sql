
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE users ADD INDEX index_users_created_at(created_at);
ALTER TABLE comments ADD INDEX index_comments_created_at(created_at);
ALTER TABLE posts ADD INDEX index_posts_created_at(created_at);

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
ALTER TABLE users DROP INDEX index_users_created_at;
ALTER TABLE comments DROP INDEX index_comments_created_at;
ALTER TABLE posts DROP INDEX index_posts_created_at;

