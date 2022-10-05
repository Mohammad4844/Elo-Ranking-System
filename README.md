# Elo Ranking System
This is a Ranking System based on the 'Elo rating'. The Elo Rating system is one that is commonly used in competetvie spaces, expecially Chess and ESports.
<br><br>
[Here's](https://en.wikipedia.org/wiki/Elo_rating_system) the wikipedia article to get a better understanding of how it works, but general gist of it is that your score is adjusted depending on what type of player you play against. If you win against an extremely good player per your standards, you would get a very large boost in your score; if you loose against them, you would be penalized but not by alot.
<br><br>
This program also implements Selective Pairing (in games, is known as Skill Based Matchmaking), where players/items are matchmade not randomly, but based on their rating, against players of around the same level as them. A person with a Rating of 1000 could be matched against a player with a rating near theirs, like 900, 1075 or 1200. They would'nt, however, be matched against a player with a Rating of 2500, as that would be really unfair (for the both of them).
<br><br>
Run `main.rb` to access the program!

## My Ratings
Here's some some of the ranking lists I made with this system:
- [Video Games](saved_data/video_games.csv)
- [TV Shows](saved_data/shows.csv)

## The Theory
Lets say you have 2 players, $A$ and $B$. They have ratings $R_A$ and $R_B$
<br>
First, the expected chance of winning is calculated for each player in a match, $E_A$ and $E_B$, using the formula:
$$E_A = \frac{1}{1+10^{\frac{R_B - R_A}{400}}}$$
Using this Expected Score, you can calculate the new adjusted ratings $R'_A$ and $R'_B$ after an outcome of a match is determinded. The formula used is:
$$R'_A = R_A * K(S_A-E_A)$$
Here, the $S$ is the score of the player. $S=1$ for a win, $S=0$ for a loss, and for some cases where ties are possible, $S=0.5$.
<br>
<br>
There is also $K$, which is the k-factor. This is an adjustment factor used as a maximum that any player can increase their score by. Some systems use a constant $K$, but newer systems (and this project too), use different tiers. $K=40$ when $R<2100$, $K=20$ when $R>2100$ and $R<2400$ and $K=10$ when $R>2400$