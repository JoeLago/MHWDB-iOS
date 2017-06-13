SELECT * FROM items WHERE min_caravan_rank IS NOT NULL ORDER BY min_caravan_rank
SELECT * FROM items WHERE min_guild_rank IS NOT NULL ORDER BY min_guild_rank

SELECT * FROM items WHERE (min_caravan_rank IS NULL AND min_guild_rank IS NULL) AND items.sub_type != ''
3591

SELECT * FROM items WHERE (min_caravan_rank IS NULL AND min_guild_rank IS NULL)
955
4451

SELECT * FROM components LEFT JOIN items ON components.component_item_id = items._id WHERE name LIKE '%%'
SELECT * FROM components LEFT JOIN items ON components.component_item_id = items._id WHERE name LIKE '%Kut-Ku Carapace%' 433

// need to do trades