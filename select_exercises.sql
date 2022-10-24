SELECT * FROM albums;
SELECT DISTINCT artist FROM albums;
DESCRIBE albums;
SELECT release_date, name FROM albums ORDER BY release_date ASC; 

/* a. How many rows are in the albums table?

b. How many unique artist names are in the albums table?

c. What is the primary key for the albums table?

d. What is the oldest release date for any album in the albums table? What is the most recent release date?

a. 31 rows

b. 23 artists

c. ID is primary key

d. Sgt. Pepper's Lonely Hearts Club Band (1967) 21 (2011)
*/
SELECT name FROM albums WHERE artist = "Pink Floyd";
SELECT genre FROM albums WHERE name = "Nevermind";
SELECT name FROM albums WHERE release_date BETWEEN '1990-1-1' AND '1999-12-31';
SELECT name FROM albums WHERE sales < 20;
SELECT name FROM albums WHERE genre = "Rock";
/* Write queries to find the following information:

a. The name of all albums by Pink Floyd

b. The year Sgt. Pepper's Lonely Hearts Club Band was released

c. The genre for the album Nevermind

d. Which albums were released in the 1990s

e. Which albums had less than 20 million certified sales

f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?

a. The Dark Side of the Moon and The Wall

b. 1967

c. Grunge, Alternative Rock

d. The Bodyguard
Jagged Little Pill
Come On Over
Falling into You
Let's Talk About Love
Dangerous
The Immaculate Collection
Titanic: Music from the Motion Picture
Metallica
Nevermind
Supernatural

e.Grease: The Original Soundtrack from the Motion Picture
Bad
Sgt. Pepper's Lonely Hearts Club Band
Dirty Dancing
Let's Talk About Love
Dangerous
The Immaculate Collection
Abbey Road
Born in the U.S.A.
Brothers in Arms
Titanic: Music from the Motion Picture
Nevermind
The Wall

f. Sgt. Pepper's Lonely Hearts Club Band
1
Abbey Road
Born in the U.S.A.
Supernatural
It does not include Hard Rock because Hard Rock is classified as its own genre within the database
*/