-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE if exists tournament;

CREATE DATABASE tournament;

\c tournament

CREATE TABLE player(
	player_id serial PRIMARY KEY,
	player_name text
);

CREATE TABLE swissmatch(
	match_id serial PRIMARY KEY,
	winner int,
	loser int,
	FOREIGN KEY(winner) REFERENCES player(player_id),
	FOREIGN KEY(loser) REFERENCES player(player_id)
);

CREATE VIEW standings AS
SELECT p.player_id as player_id, p.player_name,
(SELECT count(*) FROM swissmatch WHERE swissmatch.winner = p.player_id) as won,
(SELECT count(*) FROM swissmatch WHERE p.player_id in (winner, loser)) as played
FROM player p
GROUP BY p.player_id
ORDER BY won DESC;











