
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE users ADD INDEX index_del_flg(del_flg);


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
ALTER TABLE users DROP INDEX index_del_flg;
