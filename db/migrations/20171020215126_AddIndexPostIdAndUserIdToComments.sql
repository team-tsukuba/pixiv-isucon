
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE comments ADD INDEX index_post_id(post_id);
ALTER TABLE comments ADD INDEX index_user_id(user_id);

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
ALTER TABLE comments DROP INDEX index_post_id;
ALTER TABLE comments DROP INDEX index_user_id;

