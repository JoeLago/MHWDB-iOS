/* locations */

UPDATE locations SET min_caravan_low = (SELECT min(stars) FROM quests WHERE locations._id == quests.location_id AND hub == 'Caravan' AND stars <= 6);
UPDATE locations SET min_caravan_high = (SELECT min(stars) FROM quests WHERE locations._id == quests.location_id AND hub == 'Caravan' AND stars >= 7);

UPDATE locations SET min_guild_low = (SELECT min(stars) FROM quests WHERE locations._id == quests.location_id AND hub == 'Guild' AND stars <= 3);
UPDATE locations SET min_guild_high = (SELECT min(stars) FROM quests WHERE locations._id == quests.location_id AND hub == 'Guild' AND stars >= 4 AND stars <= 7);
UPDATE locations SET min_guild_g = (SELECT min(stars) FROM quests WHERE locations._id == quests.location_id AND hub == 'Guild' AND stars >= 8);

/* monsters */

UPDATE monsters SET min_caravan_low = (SELECT min(quests.stars) FROM monster_to_quest LEFT JOIN quests ON quests._id = monster_to_quest.quest_id WHERE monster_to_quest.monster_id == monsters._id AND quests.hub == 'Caravan' AND stars <= 6);
UPDATE monsters SET min_caravan_high = (SELECT min(quests.stars) FROM monster_to_quest LEFT JOIN quests ON quests._id = monster_to_quest.quest_id WHERE monster_to_quest.monster_id == monsters._id AND quests.hub == 'Caravan' AND stars >= 7);

UPDATE monsters SET min_guild_low = (SELECT min(quests.stars) FROM monster_to_quest LEFT JOIN quests ON quests._id = monster_to_quest.quest_id WHERE monster_to_quest.monster_id == monsters._id AND quests.hub == 'Guild' AND stars <= 3);
UPDATE monsters SET min_guild_high = (SELECT min(quests.stars) FROM monster_to_quest LEFT JOIN quests ON quests._id = monster_to_quest.quest_id WHERE monster_to_quest.monster_id == monsters._id AND quests.hub == 'Guild' AND stars >= 4 AND stars <= 7);
UPDATE monsters SET min_guild_g = (SELECT min(quests.stars) FROM monster_to_quest LEFT JOIN quests ON quests._id = monster_to_quest.quest_id WHERE monster_to_quest.monster_id == monsters._id AND quests.hub == 'Guild' AND stars >= 8);

UPDATE monsters SET min_caravan_low = 0 WHERE min_caravan_low IS NULL AND class = 'Minion';
UPDATE monsters SET min_caravan_high = 0 WHERE min_caravan_high IS NULL AND class = 'Minion';
UPDATE monsters SET min_guild_low = 0 WHERE min_guild_low IS NULL AND class = 'Minion';
UPDATE monsters SET min_guild_high = 0 WHERE min_guild_high IS NULL AND class = 'Minion';
UPDATE monsters SET min_guild_g = 0 WHERE min_guild_g IS NULL AND class = 'Minion';

/* gathering */

UPDATE gathering set min_caravan_rank = (SELECT min(min_caravan_high) FROM locations WHERE gathering.location_id = locations._id) WHERE gathering.rank == 'HR';
UPDATE gathering set min_caravan_rank = (SELECT min(min_caravan_low) FROM locations WHERE gathering.location_id = locations._id) WHERE gathering.rank == 'LR';
UPDATE gathering set min_guild_rank = (SELECT min(min_guild_g) FROM locations WHERE gathering.location_id = locations._id) WHERE gathering.rank == 'G';
UPDATE gathering set min_guild_rank = (SELECT min(min_guild_high) FROM locations WHERE gathering.location_id = locations._id) WHERE gathering.rank == 'HR';
UPDATE gathering set min_guild_rank = (SELECT min(min_guild_low) FROM locations WHERE gathering.location_id = locations._id) WHERE gathering.rank == 'LR';

/* hunting_rewards */

UPDATE hunting_rewards set min_caravan_rank = (SELECT min(min_caravan_high) FROM monsters WHERE hunting_rewards.monster_id = monsters._id) WHERE hunting_rewards.rank == 'HR';
UPDATE hunting_rewards set min_caravan_rank = (SELECT min(min_caravan_low) FROM monsters WHERE hunting_rewards.monster_id = monsters._id) WHERE hunting_rewards.rank == 'LR';

UPDATE hunting_rewards set min_guild_rank = (SELECT min(min_guild_g) FROM monsters WHERE hunting_rewards.monster_id = monsters._id) WHERE hunting_rewards.rank == 'G';
UPDATE hunting_rewards set min_guild_rank = (SELECT min(min_guild_high) FROM monsters WHERE hunting_rewards.monster_id = monsters._id) WHERE hunting_rewards.rank == 'HR';
UPDATE hunting_rewards set min_guild_rank = (SELECT min(min_guild_low) FROM monsters WHERE hunting_rewards.monster_id = monsters._id) WHERE hunting_rewards.rank == 'LR';

/* quest_rewards */

UPDATE quest_rewards set min_caravan_rank = (SELECT quests.stars FROM quests WHERE quests._id = quest_rewards._id AND quests.hub == 'Caravan');
UPDATE quest_rewards set min_guild_rank = (SELECT quests.stars FROM quests WHERE quests._id = quest_rewards._id AND quests.hub == 'Guild');

/* Helper data in place time to update items */

UPDATE items SET min_caravan_rank = null;
UPDATE items SET min_guild_rank = null;

UPDATE items SET min_caravan_rank = (SELECT MIN(gathering.min_caravan_rank) FROM gathering WHERE gathering.item_id = items._id) WHERE items.min_caravan_rank IS NULL OR EXISTS (SELECT gathering.min_caravan_rank FROM gathering WHERE gathering.item_id = items._id AND gathering.min_caravan_rank < items.min_caravan_rank);

UPDATE items SET min_guild_rank = (SELECT MIN(gathering.min_guild_rank) FROM gathering WHERE gathering.item_id = items._id) WHERE items.min_guild_rank IS NULL OR EXISTS (SELECT gathering.min_guild_rank FROM gathering WHERE gathering.item_id = items._id AND gathering.min_guild_rank < items.min_guild_rank);

UPDATE items SET min_caravan_rank = (SELECT MIN(hunting_rewards.min_caravan_rank) FROM hunting_rewards WHERE hunting_rewards.item_id = items._id) WHERE items.min_caravan_rank IS NULL OR EXISTS (SELECT hunting_rewards.min_caravan_rank FROM hunting_rewards WHERE hunting_rewards.item_id = items._id AND hunting_rewards.min_caravan_rank < items.min_caravan_rank);

UPDATE items SET min_guild_rank = (SELECT MIN(hunting_rewards.min_guild_rank) FROM hunting_rewards WHERE hunting_rewards.item_id = items._id) WHERE items.min_guild_rank IS NULL OR EXISTS (SELECT hunting_rewards.min_guild_rank FROM hunting_rewards WHERE hunting_rewards.item_id = items._id AND hunting_rewards.min_guild_rank < items.min_guild_rank);

UPDATE items SET min_caravan_rank = (SELECT MIN(quest_rewards.min_caravan_rank) FROM quest_rewards WHERE quest_rewards.item_id = items._id) WHERE items.min_caravan_rank IS NULL OR EXISTS (SELECT quest_rewards.min_caravan_rank FROM quest_rewards WHERE quest_rewards.item_id = items._id AND quest_rewards.min_caravan_rank < items.min_caravan_rank);

UPDATE items SET min_guild_rank = (SELECT MIN(quest_rewards.min_guild_rank) FROM quest_rewards WHERE quest_rewards.item_id = items._id) WHERE items.min_guild_rank IS NULL OR EXISTS (SELECT quest_rewards.min_guild_rank FROM quest_rewards WHERE quest_rewards.item_id = items._id AND quest_rewards.min_guild_rank < items.min_guild_rank);

/* Combining */

UPDATE combining SET min_caravan_rank = (SELECT MIN(items.min_caravan_rank) FROM items WHERE combining.item_1_id = items._id) WHERE combining.min_caravan_rank IS NULL OR EXISTS (SELECT items.min_caravan_rank FROM items WHERE combining.item_1_id = items._id AND items.min_caravan_rank < combining.min_caravan_rank);
UPDATE combining SET min_caravan_rank = (SELECT MIN(items.min_caravan_rank) FROM items WHERE combining.item_2_id = items._id) WHERE combining.min_caravan_rank IS NULL OR EXISTS (SELECT items.min_caravan_rank FROM items WHERE combining.item_2_id = items._id AND items.min_caravan_rank < combining.min_caravan_rank);

UPDATE combining SET min_guild_rank = (SELECT MIN(items.min_guild_rank) FROM items WHERE combining.item_1_id = items._id) WHERE combining.min_guild_rank IS NULL OR EXISTS (SELECT items.min_guild_rank FROM items WHERE combining.item_1_id = items._id AND items.min_guild_rank < combining.min_guild_rank);
UPDATE combining SET min_guild_rank = (SELECT MIN(items.min_guild_rank) FROM items WHERE combining.item_2_id = items._id) WHERE combining.min_guild_rank IS NULL OR EXISTS (SELECT items.min_guild_rank FROM items WHERE combining.item_2_id = items._id AND items.min_guild_rank < combining.min_guild_rank);

/* Combining Result Item */

UPDATE items SET min_caravan_rank = (SELECT MIN(combining.min_caravan_rank) FROM combining WHERE combining.item_1_id = items._id OR combining.item_2_id = items._id) WHERE items.min_caravan_rank IS NULL OR EXISTS (SELECT combining.min_caravan_rank FROM combining WHERE (combining.item_1_id = items._id OR combining.item_2_id = items._id) AND combining.min_caravan_rank < items.min_caravan_rank);

UPDATE items SET min_guild_rank = (SELECT MIN(combining.min_guild_rank) FROM combining WHERE combining.item_1_id = items._id OR combining.item_2_id = items._id) WHERE items.min_guild_rank IS NULL OR EXISTS (SELECT combining.min_guild_rank FROM combining WHERE (combining.item_1_id = items._id OR combining.item_2_id = items._id) AND combining.min_guild_rank < items.min_guild_rank);

/* Components */

UPDATE components set min_caravan_rank = (SELECT MIN(min_caravan_rank) FROM items WHERE components.component_item_id = items._id);
UPDATE components set min_guild_rank = (SELECT MIN(min_guild_rank) FROM items WHERE components.component_item_id = items._id);

/* Armor, Weapons, Decorations */

UPDATE items SET min_caravan_rank = (SELECT MAX(components.min_caravan_rank) FROM components WHERE components.created_item_id = items._id AND components.min_caravan_rank IS NOT NULL) WHERE items.min_caravan_rank IS NULL OR EXISTS (SELECT components.min_caravan_rank FROM components WHERE components.created_item_id = items._id AND components.min_caravan_rank > items.min_caravan_rank  AND components.min_caravan_rank IS NOT NULL);

UPDATE items SET min_guild_rank = (SELECT MAX(components.min_guild_rank) FROM components WHERE components.created_item_id = items._id AND components.min_guild_rank IS NOT NULL) WHERE items.min_guild_rank IS NULL OR EXISTS (SELECT components.min_guild_rank FROM components WHERE components.created_item_id = items._id AND components.min_guild_rank > items.min_guild_rank  AND components.min_guild_rank IS NOT NULL);

/* Clear Armor/Weapon/Decoration minimum rank where a component isn't obtainable */

UPDATE items SET min_caravan_rank = NULL WHERE items.sub_type != '' AND EXISTS (SELECT components.created_item_id FROM components WHERE components.created_item_id = items._id AND components.min_caravan_rank IS NULL);
UPDATE items SET min_guild_rank = NULL WHERE items.sub_type != '' AND EXISTS (SELECT components.created_item_id FROM components WHERE components.created_item_id = items._id AND components.min_guild_rank IS NULL);







