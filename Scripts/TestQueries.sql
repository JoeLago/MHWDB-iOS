/* These queries are to double check results from MinRank.sql */

/* Sources */
SELECT name, min_village_low, min_village_high, min_guild_low, min_guild_high FROM locations
SELECT name, min_village_low, min_village_high, min_guild_low, min_guild_high FROM monsters

/* Relationship Links */
SELECT name, gathering.min_village_rank, gathering.min_guild_rank FROM gathering LEFT JOIN items on gathering.item_id = items._id
SELECT min_village_rank, min_guild_rank FROM combining

SELECT * FROM components

SELECT 
created._id as created_id, 
created.name as created_name, 
component._id as component_id, 
component.name as component_name, 
components.min_village_rank, 
components.min_guild_rank 
FROM components 
left join items as created on created._id = created_item_id 
left join items as component on component._id = component_item_id;

/* Results */

SELECT weapons._id, name, min_village_rank, min_guild_rank FROM weapons LEFT JOIN items ON weapons._id = items._id 




/* Other */

SELECT * FROM items WHERE min_village_rank IS NOT NULL ORDER BY min_village_rank
SELECT * FROM items WHERE min_guild_rank IS NOT NULL ORDER BY min_guild_rank
SELECT * FROM items WHERE (min_village_rank IS NULL AND min_guild_rank IS NULL) AND items.sub_type != ''
SELECT * FROM items WHERE (min_village_rank IS NULL AND min_guild_rank IS NULL)

SELECT * FROM components LEFT JOIN items ON components.component_item_id = items._id WHERE name LIKE '%%'
SELECT * FROM components LEFT JOIN items ON components.component_item_id = items._id WHERE name LIKE '%Kut-Ku Carapace'


/* Testing */

787 Hyper Khezu hide
411 Thunder Sac
select * from quest_rewards where item_id = 787
select * from quest_rewards left join quests on quest_id = quests._id where item_id = 787
select * from quests where _id = 10660