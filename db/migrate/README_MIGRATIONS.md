# Migration Consolidation

## Original vs. Consolidated Migrations

This project's database schema has been consolidated from many small incremental migrations into a few comprehensive ones for clarity and maintainability.

## Consolidated Migrations

1. **20250421194050_devise_create_users.rb** - Users table with Devise setup (original migration)
2. **20250512185100_consolidated_posts.rb** - Complete posts table
3. **20250512185200_consolidated_categories.rb** - Complete categories table
4. **20250512185300_consolidated_post_likes.rb** - Complete post_likes table
5. **20250512185400_consolidated_post_comments.rb** - Complete post_comments table

## Removed Migrations

These incremental migrations have been consolidated:

- 20250422131732_create_posts.rb
- 20250423085147_create_categories.rb
- 20250423085333_add_fields_to_posts.rb
- 20250423091015_add_creator_to_posts.rb
- 20250423091255_remove_user_id_from_posts.rb
- 20250424084519_create_post_comments.rb
- 20250424085509_add_post_comment_references.rb
- 20250424094705_add_ancestry_to_post_comments.rb
- 20250425121030_create_post_likes.rb
- 20250508182156_add_not_null_constraint_to_category_name.rb
- 20250508182506_add_likes_count_to_posts.rb
- 20250508183538_add_unique_index_to_post_likes_and_categories.rb
- 20250511153336_change_category_id_null_in_posts.rb
- 20250512090357_rename_post_likes_to_likes.rb
- 20250512111959_rename_table_likes_to_post_likes.rb
- 20250512134038_rename_columns_in_post_likes.rb
- 20250512134234_revert_columns_in_post_likes.rb
- 20250512135001_rename_columns_to_post_and_user.rb

## Implementation Notes

If working with an existing database, you should:

1. Run `rails db:schema:load` instead of `rails db:migrate` for a fresh database
2. For production systems, consider using a schema dump and load approach

## Schema Structure

### Users
- Core authentication table (managed by Devise)
- Has many posts, comments, and likes

### Posts
- Title, body content
- Belongs to a category (optional)
- Belongs to a creator (user)
- Has likes counter cache

### Categories
- Name (unique, not null)
- Has many posts

### Post Likes
- References user and post
- Has unique index to prevent duplicate likes
- Uses custom column names 'user' and 'post'
- Has nullable timestamps

### Post Comments
- Content text
- References post and user
- Uses ancestry for threaded comments

## Important Model Relationships

- `Like` model uses custom table name 'post_likes'
- `Post` belongs to `User` through creator_id
- All foreign keys and indexes are properly defined