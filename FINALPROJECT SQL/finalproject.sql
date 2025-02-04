create database streamflix;
use streamflix;

create table content(
    
    contentID varchar(20),
    title varchar(200)  not null,
    description text not null,
    contentType enum ('Movie', 'TV Series'),
    rating double check (rating >= 0 and rating <= 10),
    releaseDate date not null,
    contentCover varchar(1500),
    primary key(contentID)
);

create table genre(
    genreID varchar(20),
    genreName varchar(50) not null unique,
    primary key(genreID)
);

create table content_genre(
    contentID varchar(20),
    genreID varchar(20),
    primary key(contentID, genreID),
    foreign key(contentID) references content(contentID) on delete cascade,
    foreign key(genreID) references genre(genreID) on delete cascade
);

create table media(
    mediaID varchar(20),
    media longblob ,
    contentID varchar(20),
    primary key(mediaID),
    foreign key(contentID) references content(contentID) on delete cascade
);

create table tvseries(
    contentID varchar(20),
    noofSeason int not null check (noofSeason > 0),
    status varchar(20),
    primary key(contentID),
    foreign key(contentID) references content(contentID) on delete cascade
);

create table persons(
    personID varchar(20),
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    dob date ,
    personType enum ('Actor','Actress', 'Director'),
    primary key(personID)
);

create table content_persons(
    contentID varchar(20),
    personID varchar(20),
    primary key(contentID, personID),
    foreign key(contentID) references content(contentID) on delete cascade,
    foreign key(personID) references persons(personID) on delete cascade
);

create table award(
    awardID varchar(20),
    awardName varchar(50) not null,
    primary key(awardID)
);

create table content_award(
    contentID varchar(20) ,
    awardID varchar(20),
    recievedDate year not null,
    primary key(contentID, awardID),
    foreign key(contentID) references content(contentID) on delete cascade,
    foreign key(awardID) references award(awardID) on delete cascade
);

create table subscription(
    subscriptionID varchar(20),
    subscriptionType enum ('basic','gold', 'premium'),
    movielimit int not null,
    price double not null,
    primary key(subscriptionID)
);

create table user(
    userID varchar(20),
    username varchar(50) not null unique,
    password varchar(50) not null,
    email varchar(50) not null unique,
    subscriptionID varchar(20),
    primary key(userID),
    foreign key(subscriptionID) references subscription(subscriptionID) on delete set null
);

create table user_content(
    userID varchar(20),
    contentID varchar(20),
    date date not null,
    primary key(userID, contentID),
    foreign key(userID) references user(userID) on delete cascade,
    foreign key(contentID) references content(contentID) on delete cascade
);



create table creditCard(
    cardNumber varchar(20),
    expiryDate date not null,
    cvv int not null,
    userID varchar(20),
    primary key(cardNumber),
    foreign key(userID) references user(userID) on delete cascade
);

create table giftCard(
    giftCardID varchar(20),
    amount double not null,
    expiryDate date not null,
    userID varchar(20),
    primary key(giftCardID),
    foreign key (userID) references user(userID) on delete cascade
);



create table userInteractions(
    userInteractionID varchar(20),
    interactionType enum ('like','watchLater','watched','comment','rate','share'),
    interactionDate timestamp default current_timestamp,
    userID varchar(20),
    contentID varchar(20),
    primary key(userInteractionID),
    foreign key(userID) references user(userID) on delete cascade,
    foreign key(contentID) references content(contentID) on delete cascade
);






INSERT INTO content (contentID, title, description, contentType, rating, releaseDate,contentCover) VALUES
('c1', 'Inception', 'A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.', 'Movie', 8, '2010-07-16','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/inception.jpeg'),
('c2', 'Breaking Bad', 'A high school chemistry teacher turned methamphetamine manufacturer.', 'TV Series', 9, '2008-01-20','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/breaking_bad_4.png.webp'),
('c3', 'The Matrix', 'A computer hacker learns about the true nature of his reality and his role in the war against its controllers.', 'Movie', 9, '1999-03-31','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/thematrix.jpeg'),
('c4', 'The Godfather', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 'Movie', 9, '1972-03-24','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/thegodfarther.jpeg'),
('c5', 'The Dark Knight', 'When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.', 'Movie', 9, '2008-07-18','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/thedarkknight.jpeg'),
('c6', 'Pulp Fiction', 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 'Movie', 8, '1994-10-14','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/pulpfiction.jpeg'),
('c7', 'Fight Club', 'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much more.', 'Movie', 8, '1999-10-15','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/fightclub.jpeg'),
('c8', 'Forrest Gump', 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold from the perspective of an Alabama man with an IQ of 75.', 'Movie', 8, '1994-07-06','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/forrestgump.jpeg'),
('c9', 'The Shawshank Redemption', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', 'Movie', 9, '1994-09-22','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/theshawshankredemption.jpeg'),
('c10', 'The Avengers', 'Earth\'s mightiest heroes must come together and learn to fight as a team if they are to stop the mischievous Loki and his alien army from enslaving humanity.', 'Movie', 8, '2012-05-04','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/theavengers.jpeg'),
('c11', 'The Simpsons', 'The satiric adventures of a working-class family in the misfit city of Springfield.', 'TV Series', 8, '1989-12-17','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/thesimpsons.jpeg'),
('c12', 'Game of Thrones', 'Nine noble families fight for control over the lands of Westeros, while an ancient enemy returns after being dormant for millennia.', 'TV Series', 9, '2011-04-17','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/gameofthrones.jpeg'),
('c13', 'Friends', 'Follows the personal and professional lives of six twenty to thirty-something-year-old friends living in Manhattan.', 'TV Series', 8, '1994-09-22','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/friends.jpeg'),
('c14', 'The Office', 'A mockumentary on a group of typical office workers, where the workday consists of ego clashes, inappropriate behavior, and tedium.', 'TV Series', 8, '2005-03-24','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/theoffice.jpeg'),
('c15', 'Stranger Things', 'When a young boy disappears, his mother, a police chief, and his friends must confront terrifying supernatural forces in order to get him back.', 'TV Series', 8, '2016-07-15','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/strangerthings.jpeg'),
('c16', 'The Mandalorian', 'The travels of a lone bounty hunter in the outer reaches of the galaxy, far from the authority of the New Republic.', 'TV Series', 8, '2019-11-12','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/mandalorian.jpeg'),
('c17', 'Avatar', 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.', 'Movie', 7, '2009-12-18','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/avatar.jpeg'),
('c18', 'Avengers: Endgame', 'After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos\' actions and restore balance to the universe.', 'Movie', 8, '2019-04-26','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/endgame.jpeg'),
('c19', 'Titanic', 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.', 'Movie', 8, '1997-12-19','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/titanic.jpeg'),
('c20', 'The Lion King', 'Lion prince Simba and his father are targeted by his bitter uncle, who wants to ascend the throne himself.', 'Movie', 8, '1994-06-24','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/thelionking.jpeg'),
('c21', 'Jurassic Park', 'A pragmatic paleontologist visiting an almost complete theme park is tasked with protecting a couple of kids after a power failure causes the park\'s cloned dinosaurs to run loose.', 'Movie', 8, '1993-06-11','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/jurrasicpark.jpeg'),
('c22', 'The Matrix Reloaded', 'Neo and his allies race against time before the machines discover the city of Zion and destroy it.', 'Movie', 7, '2003-05-15','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/matrixreloaded.jpeg'),
('c23', 'Star Wars: Episode IV - A New Hope', 'Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids to save the galaxy from the Empire\'s world-destroying battle station, while also attempting to rescue Princess Leia from the mysterious Darth Vader.', 'Movie', 8, '1977-05-25','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/starwarsiv.jpeg'),
('c24', 'The Empire Strikes Back', 'After the Rebels are brutally overpowered by the Empire on the ice planet Hoth, Luke Skywalker begins Jedi training with Yoda, while his friends are pursued across the galaxy by Darth Vader and bounty hunter Boba Fett.', 'Movie', 8, '1980-05-21','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/empire stikes back.jpeg'),
('c25', 'Interstellar', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.', 'Movie', 8, '2014-11-07','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/interstreller.jpeg'),
('c26', 'Coco', 'Aspiring musician Miguel, confronted with his family\'s ancestral ban on music, enters the Land of the Dead to find his great-great-grandfather, a legendary singer.', 'Movie', 8, '2017-11-22','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/coco.jpeg'),
('c27', 'Harry Potter and the Philosopher\'s Stone', 'An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family and the terrible evil that haunts the magical world.', 'Movie', 8, '2001-11-16','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/harry potter stone.jpeg'),
('c28', 'Harry Potter and the Chamber of Secrets', 'An ancient prophecy seems to be coming true when a mysterious presence begins stalking the corridors of a school of magic and leaving its victims paralyzed.', 'Movie', 7, '2002-11-15','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/harrypotterchamber.jpeg'),
('c29', 'The Lord of the Rings: The Fellowship of the Ring', 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.', 'Movie', 9, '2001-12-19','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/lordoftherigns fellowship of the ring.jpeg'),
('c30', 'The Lord of the Rings: The Two Towers', 'While Frodo and Sam edge closer to Mordor with the help of the shifty Gollum, the divided fellowship makes a stand against Sauron\'s new ally, Saruman, and his hordes of Isengard.', 'Movie', 8, '2002-12-18','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/the two towers.jpeg'),
('c31', 'The Lord of the Rings: The Return of the King', 'Gandalf and Aragorn lead the World of Men against Sauron\'s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.', 'Movie', 9, '2003-12-17','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/return of the king.jpeg'),
('c32', 'The Hobbit: An Unexpected Journey', 'A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home and the gold within it from the dragon Smaug.', 'Movie', 7, '2012-12-14','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/hobbitunexpectedjourney.jpeg'),
('c33', 'The Hobbit: The Desolation of Smaug', 'The dwarves, along with Bilbo Baggins and Gandalf the Grey, continue their quest to reclaim Erebor, their homeland, from Smaug. Bilbo Baggins is in possession of a mysterious and magical ring.', 'Movie', 7, '2013-12-13','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/desolation of the smaug.jpeg'),
('c34', 'The Hobbit: The Battle of the Five Armies', 'Bilbo and Company are forced to engage in a war against an array of combatants and keep the terrifying Smaug from acquiring a kingdom of treasure and obliterating all of Middle-Earth.', 'Movie', 7, '2014-12-17','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/the battle of five armies.jpeg'),
('c35', 'Black Panther', 'T\'Challa, heir to the hidden but advanced kingdom of Wakanda, must step forward to lead his people into a new future and must confront a challenger from his country\'s past.', 'Movie', 8, '2018-02-16','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/blackpanther.jpeg'),
('c36', 'Captain Marvel', 'Carol Danvers becomes one of the universe\'s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races.', 'Movie', 7, '2019-03-08','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/captainmarvel.jpeg'),
('c37', 'Wonder Woman', 'When a pilot crashes and tells of conflict in the outside world, Diana, an Amazonian warrior in training, leaves home to fight a war, discovering her full powers and true destiny.', 'Movie', 7, '2017-06-02','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/wonderwoman.jpeg'),
('c38', 'Spider-Man: Homecoming', 'Peter Parker balances his life as an ordinary high school student in Queens with his superhero alter-ego Spider-Man, and finds himself on the trail of a new menace prowling the skies of New York City.', 'Movie', 7, '2017-07-07','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/spiderman homecoming.jpeg'),
('c39', 'Guardians of the Galaxy', 'A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.', 'Movie', 8, '2014-08-01','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/guardians of the galaxy.jpeg'),
('c40', 'Doctor Strange', 'While on a journey of physical and spiritual healing, a brilliant neurosurgeon is drawn into the world of the mystic arts.', 'Movie', 7, '2016-11-04','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/doctor strange.jpeg'),
('c41', 'Iron Man', 'After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.', 'Movie', 8, '2008-05-02','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/iron man.jpeg'),
('c42', 'Thor', 'The powerful but arrogant god Thor is cast out of Asgard to live amongst humans in Midgard (Earth), where he soon becomes one of their finest defenders.', 'Movie', 7, '2011-05-06','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/thor.jpeg'),
('c43', 'Deadpool', 'A wisecracking mercenary gets experimented on and becomes immortal but ugly, and sets out to track down the man who ruined his looks.', 'Movie', 8, '2016-02-12','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/deadpool.jpeg'),
('c44', 'Ant-Man', 'Armed with a super-suit with the astonishing ability to shrink in scale but increase in strength, master thief Scott Lang must embrace his inner hero and help his mentor, Dr. Hank Pym, plan and pull off a heist that will save the world.', 'Movie', 7, '2015-07-17','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/antman.jpeg'),
('c45', 'The Big Bang Theory', 'A group of friends including two physicists, a waitress, and an aerospace engineer navigate their way through social situations, dating, and scientific discovery.', 'TV Series', 8, '2007-09-24','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/thebigbang theory.jpeg'),
('c46', 'How I Met Your Mother', 'A man narrates the story of how he met his children\'s mother, recounting his young adulthood and his group of friends in New York City.', 'TV Series', 8, '2005-09-19','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/howimeturmother.jpeg'),
('c47', 'Narcos', 'The true-life stories of the drug kingpins of the late 1980s and the efforts of law enforcement to bring them down.', 'TV Series', 8, '2015-08-28','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/narcos.jpeg'),
('c48', 'Money Heist', 'A criminal mastermind who goes by "The Professor" plans the biggest heist in recorded history. To carry out the ambitious plan, he recruits a band of eight robbers who have a single characteristic: a desire for money.', 'TV Series', 8, '2017-05-02','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/moneyheist.jpeg'),
('c49', 'The Witcher', 'Geralt of Rivia, a solitary monster hunter, struggles to find his place in a world where people often prove more wicked than beasts.', 'TV Series', 8, '2019-12-20','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/thewitcher.jpeg'),
('c50', 'Dark', 'A family saga with a supernatural twist, set in a German town, where the disappearance of two young children exposes the relationships among four estranged families.', 'TV Series', 8, '2017-12-01','/Users/sadukaathukorala/Desktop/relation DBMS/final project 2/contentcover/dark.jpeg');


INSERT INTO genre (genreID, genreName) VALUES
('g1', 'Sci-Fi'),
('g2', 'Drama'),
('g3', 'Action'),
('g4', 'Thriller'),
('g5', 'Adventure'),
('g6', 'Fantasy'),
('g7', 'Comedy'),
('g8', 'Mystery'),
('g9', 'Crime'),
('g10', 'Romance');


INSERT INTO content_genre (contentID, genreID) VALUES
('c1', 'g1'),
('c1', 'g4'),
('c2', 'g2'),
('c2', 'g3'),
('c3', 'g1'),
('c3', 'g4'),
('c4', 'g2'),
('c4', 'g9'),
('c5', 'g1'),
('c5', 'g3'),
('c6', 'g1'),
('c6', 'g4'),
('c7', 'g1'),
('c7', 'g4'),
('c8', 'g2'),
('c8', 'g3'),
('c9', 'g2'),
('c9', 'g4'),
('c10', 'g3'),
('c10', 'g5'),
('c11', 'g7'),
('c12', 'g1'),
('c12', 'g4'),
('c13', 'g7'),
('c13', 'g10'),
('c14', 'g7'),
('c14', 'g9'),
('c15', 'g1'),
('c15', 'g4'),
('c16', 'g1'),
('c16', 'g5'),
('c17', 'g1'),
('c17', 'g5'),
('c18', 'g1'),
('c18', 'g4'),
('c19', 'g5'),
('c19', 'g10'),
('c20', 'g5'),
('c20', 'g7'),
('c21', 'g1'),
('c21', 'g5'),
('c22', 'g1'),
('c22', 'g4'),
('c23', 'g1'),
('c23', 'g5'),
('c24', 'g1'),
('c24', 'g4'),
('c25', 'g1'),
('c25', 'g5'),
('c26', 'g5'),
('c26', 'g7'),
('c27', 'g6'),
('c27', 'g7'),
('c28', 'g6'),
('c28', 'g7'),
('c29', 'g1'),
('c29', 'g5'),
('c30', 'g1'),
('c30', 'g5'),
('c31', 'g1'),
('c31', 'g5'),
('c32', 'g1'),
('c32', 'g5'),
('c33', 'g1'),
('c33', 'g5'),
('c34', 'g1'),
('c34', 'g5'),
('c35', 'g1'),
('c35', 'g7'),
('c36', 'g1'),
('c36', 'g7'),
('c37', 'g6'),
('c37', 'g7'),
('c38', 'g1'),
('c38', 'g7'),
('c39', 'g1'),
('c39', 'g5'),
('c40', 'g1'),
('c40', 'g6'),
('c41', 'g1'),
('c41', 'g3'),
('c42', 'g1'),
('c42', 'g5'),
('c43', 'g1'),
('c43', 'g7'),
('c44', 'g1'),
('c44', 'g5'),
('c45', 'g7'),
('c46', 'g7'),
('c47', 'g1'),
('c47', 'g9'),
('c48', 'g1'),
('c48', 'g3'),
('c49', 'g1'),
('c49', 'g3'),
('c50', 'g1'),
('c50', 'g8');

INSERT INTO media (mediaID, media,contentID) VALUES
('m1', LOAD_FILE('path_to_media/inception.mp4'), 'c1'), 
('m2', LOAD_FILE('path_to_media/breaking_bad.mp4'), 'c2'),
('m3', LOAD_FILE('path_to_media/matrix.mp4'),'c3'),
('m4', LOAD_FILE('path_to_media/godfather.mp4'),'c4'),
('m5', LOAD_FILE('path_to_media/dark_knight.mp4'),'c5'),
('m6', LOAD_FILE('path_to_media/pulp_fiction.mp4'),'c6'),
('m7', LOAD_FILE('path_to_media/fight_club.mp4'),'c7'),
('m8', LOAD_FILE('path_to_media/forrest_gump.mp4'),'c8'),
('m9', LOAD_FILE('path_to_media/shawshank_redemption.mp4'),'c9'),
('m10', LOAD_FILE('path_to_media/avengers.mp4'),'c10'),
('m11', LOAD_FILE('path_to_media/simpsons.mp4'),'c11'),
('m12', LOAD_FILE('path_to_media/game_of_thrones.mp4'),'c12'),
('m13', LOAD_FILE('path_to_media/friends.mp4'),'c13'),
('m14', LOAD_FILE('path_to_media/office.mp4'),'c14'),
('m15', LOAD_FILE('path_to_media/stranger_things.mp4'),'c15'),
('m16', LOAD_FILE('path_to_media/mandalorian.mp4'),'c16'),
('m17', LOAD_FILE('path_to_media/avatar.mp4'),'c17'),
('m18', LOAD_FILE('path_to_media/endgame.mp4'),'c18'),
('m19', LOAD_FILE('path_to_media/titanic.mp4'),'c19'),
('m20', LOAD_FILE('path_to_media/lion_king.mp4'),'c20'),
('m21', LOAD_FILE('path_to_media/jurassic_park.mp4'),'c21'),
('m22', LOAD_FILE('path_to_media/matrix_reloaded.mp4'),'c22'),
('m23', LOAD_FILE('path_to_media/star_wars.mp4'),'c23'),
('m24', LOAD_FILE('path_to_media/empire_strikes_back.mp4'),'c24'),
('m25', LOAD_FILE('path_to_media/interstellar.mp4'),'c25'),
('m26', LOAD_FILE('path_to_media/coco.mp4'),'c26'),
('m27', LOAD_FILE('path_to_media/harry_potter.mp4'),'c27'),
('m28', LOAD_FILE('path_to_media/chamber_of_secrets.mp4'),'c28'),
('m29', LOAD_FILE('path_to_media/fellowship_of_the_ring.mp4'),'c29'),
('m30', LOAD_FILE('path_to_media/two_towers.mp4'),'c30'),
('m31', LOAD_FILE('path_to_media/return_of_the_king.mp4'),'c31'),
('m32', LOAD_FILE('path_to_media/hobbit_unexpected_journey.mp4'),'c32'),
('m33', LOAD_FILE('path_to_media/hobbit_desolation_of_smaug.mp4'),'c33'),
('m34', LOAD_FILE('path_to_media/hobbit_battle_of_five_armies.mp4'),'c34'),
('m35', LOAD_FILE('path_to_media/black_panther.mp4'),'c35'),
('m36', LOAD_FILE('path_to_media/captain_marvel.mp4'),'c36'),
('m37', LOAD_FILE('path_to_media/wonder_woman.mp4'),'c37'),
('m38', LOAD_FILE('path_to_media/spider_man_homecoming.mp4'),'c38'),
('m39', LOAD_FILE('path_to_media/guardians_of_galaxy.mp4'),'c39'),
('m40', LOAD_FILE('path_to_media/doctor_strange.mp4'),'c40'),
('m41', LOAD_FILE('path_to_media/iron_man.mp4'),'c41'),
('m42', LOAD_FILE('path_to_media/thor.mp4'),'c42'),
('m43', LOAD_FILE('path_to_media/deadpool.mp4'),'c43'),
('m44', LOAD_FILE('path_to_media/ant_man.mp4'),'c44'),
('m45', LOAD_FILE('path_to_media/big_bang_theory.mp4'),'c45'),
('m46', LOAD_FILE('path_to_media/how_i_met_your_mother.mp4'),'c46'),
('m47', LOAD_FILE('path_to_media/narcos.mp4'),'c47'),
('m48', LOAD_FILE('path_to_media/money_heist.mp4'),'c48'),
('m49', LOAD_FILE('path_to_media/witcher.mp4'),'c49'),
('m50', LOAD_FILE('path_to_media/dark.mp4'),'c50');


INSERT INTO tvseries (contentID, noofSeason, status) VALUES
('c2', 5, 'Completed'),
('c11', 32, 'Ongoing'),
('c12', 8, 'Completed'),
('c13', 10, 'Completed'),
('c14', 9, 'Completed'),
('c15', 3, 'Ongoing'),
('c16', 2, 'Ongoing'),
('c45', 12, 'Completed'),
('c46', 9, 'Completed'),
('c47', 3, 'Completed'),
('c48', 5, 'Completed'),
('c49', 1, 'Ongoing'),
('c50', 3, 'Completed');



-- INSERT INTO season (seasonID, seasonNumber, description, tvseriesID) VALUES
-- ('s1', 1, 'The first season of Breaking Bad', 'ts1'),
-- ('s2', 2, 'The second season of Breaking Bad', 'ts1'),
-- ('s3', 1, 'The first season of The Simpsons', 'ts2'),
-- ('s4', 2, 'The second season of The Simpsons', 'ts2'),
-- ('s5', 1, 'The first season of Game of Thrones', 'ts3'),
-- ('s6', 2, 'The second season of Game of Thrones', 'ts3'),
-- ('s7', 1, 'The first season of Friends', 'ts4'),
-- ('s8', 2, 'The second season of Friends', 'ts4'),
-- ('s9', 1, 'The first season of Stranger Things', 'ts5'),
-- ('s10', 2, 'The second season of Stranger Things', 'ts5'),
-- ('s11', 1, 'The first season of The Mandalorian', 'ts6'),
-- ('s12', 2, 'The second season of The Mandalorian', 'ts6'),
-- ('s13', 1, 'The first season of Money Heist', 'ts8'),
-- ('s14', 2, 'The second season of Money Heist', 'ts8'),
-- ('s15', 1, 'The first season of Narcos', 'ts9'),
-- ('s16', 2, 'The second season of Narcos', 'ts9'),
-- ('s17', 1, 'The first season of The Witcher', 'ts10'),
-- ('s18', 2, 'The second season of The Witcher', 'ts10');

INSERT INTO persons (personID, firstName, lastName, dob, personType) VALUES
('p1', 'Leonardo', 'DiCaprio', '1974-11-11', 'Actor'),
('p2', 'Robert', 'Pattinson', '1986-05-13', 'Actor'),
('p3', 'Morgan', 'Freeman', '1937-06-01', 'Actor'),
('p4', 'Jennifer', 'Lawrence', '1990-08-15', 'Actress'),
('p5', 'Tom', 'Hanks', '1956-07-09', 'Actor'),
('p6', 'Meryl', 'Streep', '1949-06-22', 'Actress'),
('p7', 'Scarlett', 'Johansson', '1984-11-22', 'Actress'),
('p8', 'Chris', 'Evans', '1981-06-13', 'Actor'),
('p9', 'Brad', 'Pitt', '1963-12-18', 'Actor'),
('p10', 'Emma', 'Watson', '1990-04-15', 'Actress'),
('p11', 'Matt', 'Damon', '1970-10-08', 'Actor'),
('p12', 'Ryan', 'Reynolds', '1976-10-23', 'Actor'),
('p13', 'Hugh', 'Jackman', '1968-10-12', 'Actor'),
('p14', 'Jodie', 'Foster', '1962-11-19', 'Actress'),
('p15', 'Mark', 'Ruffalo', '1967-11-22', 'Actor'),
('p16', 'Natalie', 'Portman', '1981-06-09', 'Actress'),
('p17', 'Johnny', 'Depp', '1963-06-09', 'Actor'),
('p18', 'Harrison', 'Ford', '1942-07-13', 'Actor'),
('p19', 'Kate', 'Winslet', '1975-10-05', 'Actress'),
('p20', 'Daniel', 'Craig', '1968-03-02', 'Actor'),
('p21', 'Hugh', 'Grant', '1960-09-09', 'Actor'),
('p22', 'Charlize', 'Theron', '1975-08-07', 'Actress'),
('p23', 'Denzel', 'Washington', '1954-12-28', 'Actor'),
('p24', 'Anne', 'Hathaway', '1982-11-12', 'Actress'),
('p25', 'Christian', 'Bale', '1974-01-30', 'Actor'),
('p26', 'Angelina', 'Jolie', '1975-06-04', 'Actress'),
('p27', 'Jason', 'Momoa', '1979-08-01', 'Actor'),
('p28', 'Will', 'Smith', '1968-09-25', 'Actor'),
('p29', 'Zendaya', 'Coleman', '1996-09-01', 'Actress'),
('p30', 'Robert', 'Downey Jr.', '1965-04-04', 'Actor'),
('p31', 'Ben', 'Affleck', '1972-08-15', 'Actor'),
('p32', 'Renee', 'Zellweger', '1969-04-25', 'Actress'),
('p33', 'Samuel', 'L. Jackson', '1948-12-21', 'Actor'),
('p34', 'Maggie', 'Gyllenhaal', '1977-11-16', 'Actress'),
('p35', 'Mark', 'Wahlberg', '1971-06-05', 'Actor'),
('p36', 'Tessa', 'Thompson', '1983-10-03', 'Actress'),
('p37', 'Emily', 'Blunt', '1983-02-23', 'Actress'),
('p38', 'Paul', 'Rudd', '1969-04-06', 'Actor'),
('p39', 'Jeremy', 'Renner', '1971-01-07', 'Actor'),
('p40', 'Jessica', 'Chastain', '1977-03-24', 'Actress'),
('p41', 'Cate', 'Blanchett', '1969-05-14', 'Actress'),
('p42', 'Keanu', 'Reeves', '1964-09-02', 'Actor'),
('p43', 'Emily', 'Mortimer', '1971-01-01', 'Actress'),
('p44', 'Ethan', 'Hawke', '1970-11-06', 'Actor'),
('p45', 'Javier', 'Bardem', '1969-03-01', 'Actor'),
('p46', 'Hugh', 'Dancy', '1975-06-19', 'Actor'),
('p47', 'Helen', 'Mirren', '1945-07-26', 'Actress'),
('p48', 'Richard', 'Gere', '1949-08-31', 'Actor'),
('p49', 'Saoirse', 'Ronan', '1994-04-12', 'Actress'),
('p50', 'Jeff', 'Bridges', '1949-12-04', 'Actor'),
('p51', 'Christopher', 'Nolan', '1970-07-30', 'Director'),
('p52', 'Vince', 'Gilligan', '1967-02-10', 'Director'),
('p53', 'Lana', 'Wachowski', '1965-06-21', 'Director'),
('p54', 'Lilly', 'Wachowski', '1967-12-29', 'Director'),
('p55', 'Francis Ford', 'Coppola', '1939-04-07', 'Director'),
('p56', 'Quentin', 'Tarantino', '1963-03-27', 'Director'),
('p57', 'David', 'Fincher', '1962-08-28', 'Director'),
('p58', 'Robert', 'Zemeckis', '1951-05-14', 'Director'),
('p59', 'Frank', 'Darabont', '1959-01-28', 'Director'),
('p60', 'Joss', 'Whedon', '1964-06-23', 'Director'),
('p61', 'Roger', 'Allers', '1949-06-29', 'Director'),
('p62', 'Rob', 'Minkoff', '1962-08-11', 'Director'),
('p63', 'Steven', 'Spielberg', '1946-12-18', 'Director'),
('p64', 'George', 'Lucas', '1944-05-14', 'Director'),
('p65', 'Irvin', 'Kershner', '1923-04-29', 'Director'),
('p66', 'Lee', 'Unkrich', '1967-08-08', 'Director'),
('p67', 'Adrian', 'Molina', '1972-04-14', 'Director'),
('p68', 'Chris', 'Columbus', '1958-09-10', 'Director'),
('p69', 'Peter', 'Jackson', '1961-10-31', 'Director'),
('p70', 'Ryan', 'Coogler', '1986-05-23', 'Director'),
('p71', 'Anna', 'Boden', '1976-02-20', 'Director'),
('p72', 'Ryan', 'Fleck', '1976-09-20', 'Director'),
('p73', 'Patty', 'Jenkins', '1971-07-24', 'Director'),
('p74', 'Jon', 'Watts', '1981-06-28', 'Director'),
('p75', 'James', 'Gunn', '1966-08-05', 'Director'),
('p76', 'Scott', 'Derrickson', '1966-07-16', 'Director'),
('p77', 'Jon', 'Favreau', '1966-10-19', 'Director'),
('p78', 'Kenneth', 'Branagh', '1960-12-10', 'Director'),
('p79', 'Tim', 'Miller', '1964-10-10', 'Director'),
('p80', 'Peyton', 'Reed', '1964-07-03', 'Director'),
('p81', 'Álex', 'Pina', NULL, 'Director'), 
('p82', 'Baran bo', 'Odar', '1978-04-18', 'Director'),
('p83', 'James', 'Cameron', '1954-08-16', 'Director'),
('p84', 'David', 'Silverman', '1955-03-15', 'Director'), 
('p85','Alan', 'Taylor', '1965-01-13', 'Director'), 
('p86', 'Kevin', 'Bright', '1955-11-15', 'Director'),
('p87', 'Paul', 'Feig', '1962-09-17', 'Director'),
('p88', 'Shawn', 'Levy', '1967-07-23', 'Director'),
('p89', 'Mark', 'Cendrowski', '1956-01-27', 'Director'),
('p90', 'Pamela', 'Fryman', '1959-08-19', 'Director'),
('p91', 'José', 'Padilha', '1968-08-01', 'Director'),
('p92', 'Alik', 'Sakharov', NULL, 'Director'),
('p93','Anthony','Russo','1970-02-3','Director'); 




INSERT INTO content_persons (contentID, personID) VALUES
('c1', 'p1'),
('c1', 'p3'),
('c2', 'p4'),
('c2', 'p5'),
('c3', 'p6'),
('c3', 'p7'),
('c4', 'p8'),
('c4', 'p9'),
('c5', 'p10'),
('c5', 'p11'),
('c6', 'p12'),
('c6', 'p13'),
('c7', 'p14'),
('c7', 'p15'),
('c8', 'p16'),
('c8', 'p17'),
('c9', 'p18'),
('c9', 'p19'),
('c10', 'p20'),
('c10', 'p21'),
('c11', 'p22'),
('c11', 'p23'),
('c12', 'p24'),
('c12', 'p25'),
('c13', 'p26'),
('c13', 'p27'),
('c14', 'p28'),
('c14', 'p29'),
('c15', 'p30'),
('c15', 'p31'),
('c16', 'p32'),
('c16', 'p33'),
('c17', 'p34'),
('c17', 'p35'),
('c18', 'p36'),
('c18', 'p37'),
('c19', 'p38'),
('c19', 'p39'),
('c20', 'p40'),
('c20', 'p41'),
('c21', 'p42'),
('c21', 'p43'),
('c22', 'p44'),
('c22', 'p45'),
('c23', 'p46'),
('c23', 'p47'),
('c24', 'p48'),
('c24', 'p49'),
('c25', 'p50'),
('c1','p51'),
('c10','p60'),
('c11','p84'),
('c12','p85'),
('c13','p86'),
('c14','p87'),
('c15','p88'),
('c16','p77'),
('c17','p83'),
('c18','p93'),
('c19','p83'),
('c2','p52'),
('c20','p61'),
('c21','p63'),
('c22','p53'),
('c23','p64'),
('c24','p65'),
('c25','p51'),
('c26','p66'),
('c27','p68'),
('c28','p68'),
('c29','p69'),
('c3','p54'),
('c30','p69'),
('c31','p69'),
('c32','p69'),
('c33','p69'),
('c34','p69'),
('c35','p70'),
('c36','p71'),
('c37','p73'),
('c38','p74'),
('c39','p75'),
('c4','p55'),
('c40','p76'),
('c41','p77'),
('c42','p78'),
('c43','p79'),
('c44','p80'),
('c45','p89'),
('c46','p90'),
('c47','p91'),
('c48','p81'),
('c49','p92'),
('c5','p51'),
('c50','p82'),
('c6','p56'),
('c7','p57'),
('c8','p58'),
('c9','p59');

INSERT INTO award (awardID, awardName) VALUES
('a1', 'Academy Best Picture'),
('a2', 'Academy Best Director'),
('a3', 'Academy Best Actor'),
('a4', 'Academy Best Actress'),
('a5', 'Academy Best Supporting Actor'),
('a6', 'Academy Best Supporting Actress'),
('a7', 'Academy Best Screenplay'),
('a8', 'Academy Best Cinematography'),
('a9', 'Academy Best Editing'),
('a10', 'Academy Best Visual Effects');


INSERT INTO content_award (contentID, awardID,recievedDate) VALUES
('c1','a8','2010'),
('c1','a10','2010'),
('c3','a9','1990'),
('c3','a10','1990'),
('c4','a1','1972'),
('c4','a3','1972'),
('c4','a7','1972'),
('c5','a5','2008'),
('c8','a1','1994'),
('c8','a2','1994'),
('c8','a3','1994'),
('c8','a7','1994'),
('c8','a9','1994'),
('c8','a10','1994'),
('c29','a8','2001'),
('c30','a10','2002'),
('c31','a1','2003'),
('c31','a2','2003'),
('c31','a7','2003'),
('c31','a9','2003'),
('c31','a10','2003'),
('c19','a1','1997'),
('c19','a2','1997'),
('c19','a8','1997'),
('c19','a9','1997'),
('c19','a10','1997'),
('c23','a9','1977'),
('c23','a10','1977');


insert into subscription(subscriptionID,subscriptionType,movielimit,price) values
('sub1','Basic',20,2000),
('sub2','gold',35,3000),
('sub3','Premium',50,4500);



insert into user(userID,username,password,email,subscriptionID) values
('u1','saduka08','password1','saduka.exemail.com','sub1'),
('u2','sachithra09','password2','sachithra.exemail.com','sub2'),
('u3','sachini40','password3','sachini.exemail.com','sub2'),
('u4','sachintha23','password4','sachintha.exemail.com','sub3'),
('u5','sachira12','password5','sachira.exemail.com','sub1');


insert into user_content(userID,contentID,date) values
('u1','c2','2024-07-01'),
('u1','c9','2024-07-01'),
('u1','c7','2024-07-02'),
('u1','c8','2024-07-04'),
('u1','c4','2024-07-08'),
('u1','c6','2024-07-06'),
('u1','c50','2024-07-07'),
('u1','c36','2024-07-08'),
('u1','c46','2024-07-09'),
('u1','c32','2024-07-10'),
('u1','c43','2024-07-11'),
('u1','c45','2024-07-12'),
('u1','c28','2024-07-13'),
('u1','c49','2024-07-17'),
('u1','c34','2024-07-15'),
('u1','c26','2024-07-06'),
('u1','c12','2024-07-01'),
('u1','c23','2024-07-02'),
('u1','c38','2024-07-15'),
('u1','c21','2024-07-12'),
('u2','c34','2024-07-02'),
('u2','c45','2024-07-01'),
('u2','c21','2024-07-12'),
('u2','c1','2024-07-12'),
('u2','c4','2024-07-02'),
('u2','c25','2024-07-05'),
('u2','c32','2024-07-26'),
('u2','c2','2024-07-27'),
('u2','c42','2024-07-28'),
('u2','c7','2024-07-29'),
('u3','c3','2024-07-30'),
('u3','c4','2024-07-31'),
('u3','c9','2024-07-01'),
('u3','c23','2024-07-02'),
('u3','c12','2024-07-03'),
('u3','c32','2024-07-04'),
('u4','c12','2024-07-05'),
('u4','c32','2024-07-06'),
('u4','c21','2024-07-07'),
('u4','c4','2024-07-08'),
('u5','c43','2024-07-09'),
('u5','c34','2024-07-10'),
('u5','c31','2024-07-11'),
('u5','c14','2024-07-12'),
('u5','c38','2024-07-10'),
('u5','c49','2024-07-11'),
('u5','c13','2024-07-12');




insert into creditCard (cardNumber, expiryDate, cvv, userID) values
('123456789', '2028-07-01', 123, 'u1'),
('234567890', '2029-07-02', 234, 'u2'),
('345678901', '2028-07-03', 345, 'u3'),
('456789012', '2029-07-04', 456, 'u4'),
('567890123', '2029-07-05', 567, 'u5');


insert into giftCard(giftCardID,amount,expiryDate,userID) values
('gc1',1000,'2026-07-01','u1'),
('gc2',2000,'2027-07-02','u2'),
('gc3',3000,'2025-07-03','u3'),
('gc4',4000,'2029-07-04','u4'),
('gc5',5000,'2028-07-05','u5'),
('gc6',11000,'2024-07-11','u1'),
('gc7',12000,'2025-07-12','u2'),
('gc8',13000,'2027-07-13','u3'),
('gc9',14000,'2029-07-14','u4'),
('gc10',15000,'2024-07-15','u5'),
('gc11',16000,'2028-07-16','u1'),
('gc12',17000,'2029-07-17','u2');





INSERT INTO userInteractions (userInteractionID, interactionType, interactionDate, userID, contentID) VALUES
 ('ui1', 'watched', '2024-07-01 08:00:00', 'u1', 'c2'),
    ('ui2', 'watched', '2024-07-01 10:25:22', 'u1', 'c9'),
    ('ui3', 'watched', '2024-07-02 12:30:30', 'u1', 'c7'),
    ('ui4', 'watched', '2024-07-04 08:45:45', 'u1', 'c8'),
    ('ui5', 'watched', '2024-07-08 14:00:10', 'u1', 'c4'),
    ('ui6', 'watched', '2024-07-06 16:22:35', 'u1', 'c6'),
    ('ui7', 'watched', '2024-07-07 13:50:00', 'u1', 'c50'),
    ('ui8', 'watched', '2024-07-08 15:45:30', 'u1', 'c36'),
    ('ui9', 'watched', '2024-07-09 17:30:20', 'u1', 'c46'),
    ('ui10', 'watched', '2024-07-10 11:05:45', 'u1', 'c32'),
    ('ui11', 'watched', '2024-07-11 12:25:15', 'u1', 'c43'),
    ('ui12', 'watched', '2024-07-12 14:15:10', 'u1', 'c45'),
    ('ui13', 'watched', '2024-07-13 13:45:30', 'u1', 'c28'),
    ('ui14', 'watched', '2024-07-17 10:30:20', 'u1', 'c49'),
    ('ui15', 'watched', '2024-07-15 12:05:45', 'u1', 'c34'),
    ('ui16', 'watched', '2024-07-06 08:15:22', 'u1', 'c26'),
    ('ui17', 'watched', '2024-07-01 08:50:11', 'u1', 'c12'),
    ('ui18', 'watched', '2024-07-02 08:10:55', 'u1', 'c23'),
    ('ui19', 'watched', '2024-07-15 15:30:22', 'u1', 'c38'),
    ('ui20', 'watched', '2024-07-12 10:00:00', 'u2', 'c34'),
    ('ui21', 'watched', '2024-07-01 11:15:22', 'u2', 'c45'),
    ('ui22', 'watched', '2024-07-12 12:30:30', 'u2', 'c21'),
    ('ui23', 'watched', '2024-07-12 08:45:45', 'u2', 'c1'),
    ('ui24', 'watched', '2024-07-02 14:00:10', 'u2', 'c4'),
    ('ui25', 'watched', '2024-07-05 16:22:35', 'u2', 'c25'),
    ('ui26', 'watched', '2024-07-26 13:50:00', 'u2', 'c32'),
    ('ui27', 'watched', '2024-07-27 15:45:30', 'u2', 'c2'),
    ('ui28', 'watched', '2024-07-28 17:30:20', 'u2', 'c42'),
    ('ui29', 'watched', '2024-07-29 11:05:45', 'u2', 'c7'),
    ('ui30', 'watched', '2024-07-30 12:25:15', 'u3', 'c3'),
    ('ui31', 'watched', '2024-07-31 14:15:10', 'u3', 'c4'),
    ('ui32', 'watched', '2024-07-01 13:45:30', 'u3', 'c9'),
    ('ui33', 'watched', '2024-07-02 10:30:20', 'u3', 'c23'),
    ('ui34', 'watched', '2024-07-03 12:05:45', 'u3', 'c12'),
    ('ui35', 'watched', '2024-07-04 08:15:22', 'u3', 'c32'),
    ('ui36', 'watched', '2024-07-05 09:50:11', 'u4', 'c12'),
    ('ui37', 'watched', '2024-07-06 11:10:55', 'u4', 'c32'),
    ('ui38', 'watched', '2024-07-07 13:30:30', 'u4', 'c21'),
    ('ui39', 'watched', '2024-07-08 14:45:45', 'u4', 'c4'),
    ('ui40', 'watched', '2024-07-09 15:50:22', 'u5', 'c43'),
    ('ui41', 'watched', '2024-07-10 16:15:10', 'u5', 'c34'),
    ('ui42', 'watched', '2024-07-11 17:30:20', 'u5', 'c31'),
    ('ui43', 'watched', '2024-07-12 10:30:20', 'u5', 'c14'),
    ('ui44', 'watched', '2024-07-10 12:05:45', 'u5', 'c38'),
    ('ui45', 'watched', '2024-07-11 13:50:00', 'u5', 'c49'),
    ('ui46', 'watched', '2024-07-12 14:15:10', 'u5', 'c13'),
    ('ui47', 'like', '2024-07-01 08:00:00', 'u1', 'c2'),
    ('ui48', 'like', '2024-07-01 10:25:22', 'u1', 'c9'),
    ('ui49', 'like', '2024-07-02 12:30:30', 'u1', 'c7'),
    ('ui50', 'like', '2024-07-04 08:45:45', 'u1', 'c8'),
    ('ui51', 'like', '2024-07-08 14:00:10', 'u1', 'c4'),
    ('ui52', 'like', '2024-07-06 16:22:35', 'u1', 'c6'),
    ('ui53', 'like', '2024-07-07 13:50:00', 'u1', 'c50'),
    ('ui54', 'like', '2024-07-08 15:45:30', 'u1', 'c36'),
    ('ui55', 'like', '2024-07-09 17:30:20', 'u1', 'c46'),
    ('ui56', 'like', '2024-07-10 11:05:45', 'u1', 'c32'),
    ('ui57', 'like', '2024-07-11 12:25:15', 'u1', 'c43'),
    ('ui58', 'like', '2024-07-12 14:15:10', 'u1', 'c45'),
    ('ui59', 'like', '2024-07-13 13:45:30', 'u1', 'c28'),
    ('ui60', 'like', '2024-07-17 10:30:20', 'u1', 'c49'),
    ('ui61', 'like', '2024-07-15 12:05:45', 'u1', 'c34'),
    ('ui62', 'like', '2024-07-06 08:15:22', 'u1', 'c26'),
    ('ui63', 'like', '2024-07-01 09:50:11', 'u1', 'c12'),
    ('ui64', 'like', '2024-07-02 11:10:55', 'u1', 'c23'),
    ('ui65', 'like', '2024-07-15 15:30:22', 'u1', 'c38'),
    ('ui66', 'like', '2024-07-02 10:00:00', 'u2', 'c34'),
    ('ui67', 'like', '2024-07-01 11:15:22', 'u2', 'c45'),
    ('ui68', 'like', '2024-07-12 12:30:30', 'u2', 'c21'),
    ('ui69', 'like', '2024-07-12 08:45:45', 'u2', 'c2'),
    ('ui70', 'like', '2024-07-02 14:00:10', 'u2', 'c4'),
    ('ui71', 'like', '2024-07-05 16:22:35', 'u2', 'c25'),
    ('ui72', 'like', '2024-07-26 13:50:00', 'u2', 'c32'),
    ('ui73', 'like', '2024-07-27 15:45:30', 'u2', 'c2'),
    ('ui74', 'like', '2024-07-28 17:30:20', 'u2', 'c42'),
    ('ui75', 'like', '2024-07-29 11:05:45', 'u2', 'c7'),
    ('ui76', 'like', '2024-07-30 12:25:15', 'u3', 'c3'),
    ('ui77', 'like', '2024-07-31 14:15:10', 'u3', 'c4'),
    ('ui78', 'like', '2024-07-01 13:45:30', 'u3', 'c9'),
    ('ui79', 'like', '2024-07-02 10:30:20', 'u3', 'c23'),
    ('ui80', 'like', '2024-07-03 12:05:45', 'u3', 'c12'),
    ('ui81', 'like', '2024-07-04 08:15:22', 'u3', 'c32'),
    ('ui82', 'like', '2024-07-05 09:50:11', 'u4', 'c12'),
    ('ui83', 'like', '2024-07-06 11:10:55', 'u4', 'c32'),
    ('ui84', 'like', '2024-07-07 13:30:30', 'u4', 'c21'),
    ('ui85', 'like', '2024-07-08 14:45:45', 'u4', 'c4'),
    ('ui86', 'like', '2024-07-09 15:50:22', 'u5', 'c43'),
    ('ui87', 'like', '2024-07-10 16:15:10', 'u5', 'c34'),
    ('ui88', 'like', '2024-07-11 17:30:20', 'u5', 'c31'),
    ('ui89', 'like', '2024-07-12 10:30:20', 'u5', 'c14'),
    ('ui90', 'like', '2024-07-10 12:05:45', 'u5', 'c38'),
    ('ui91', 'like', '2024-07-11 13:50:00', 'u5', 'c49'),
    ('ui92', 'like', '2024-07-12 14:15:10', 'u5', 'c13'),
    ('ui93', 'comment', '2024-07-01 10:10:00', 'u1', 'c2'),
    ('ui94', 'comment', '2024-07-01 12:15:22', 'u1', 'c9'),
    ('ui95', 'comment', '2024-07-02 12:40:30', 'u1', 'c7'),
    ('ui96', 'comment', '2024-07-04 08:45:45', 'u1', 'c8'),
    ('ui97', 'comment', '2024-07-08 14:00:10', 'u1', 'c4'),
    ('ui98', 'comment', '2024-07-06 16:22:35', 'u1', 'c6'),
    ('ui99', 'comment', '2024-07-07 13:50:00', 'u1', 'c50'),
    ('ui100', 'comment', '2024-07-08 15:45:30', 'u1', 'c36'),
    ('ui101', 'comment', '2024-07-09 17:30:20', 'u1', 'c46'),
    ('ui102', 'comment', '2024-07-10 11:05:45', 'u1', 'c32'),
    ('ui103', 'comment', '2024-07-11 12:25:15', 'u1', 'c43'),
    ('ui104', 'comment', '2024-07-12 14:15:10', 'u1', 'c45'),
    ('ui105', 'comment', '2024-07-13 13:45:30', 'u1', 'c28'),
    ('ui106', 'comment', '2024-07-17 10:30:20', 'u1', 'c49'),
    ('ui107', 'comment', '2024-07-15 12:05:45', 'u1', 'c34'),
    ('ui108', 'comment', '2024-07-06 08:15:22', 'u1', 'c26'),
    ('ui109', 'comment', '2024-07-01 09:50:11', 'u1', 'c12'),
    ('ui110', 'comment', '2024-07-02 11:10:55', 'u1', 'c23'),
    ('ui111', 'comment', '2024-07-15 15:30:22', 'u1', 'c38'),
    ('ui112', 'comment', '2024-07-02 10:00:00', 'u2', 'c34'),
    ('ui113', 'comment', '2024-07-01 11:15:22', 'u2', 'c45'),
    ('ui114', 'comment', '2024-07-12 12:30:30', 'u2', 'c21'),
    ('ui115', 'comment', '2024-07-12 08:45:45', 'u2', 'c2'),
    ('ui116', 'comment', '2024-07-02 14:00:10', 'u2', 'c4'),
    ('ui117', 'comment', '2024-07-05 16:22:35', 'u2', 'c25'),
    ('ui118', 'comment', '2024-07-26 13:50:00', 'u2', 'c32'),
    ('ui119', 'comment', '2024-07-27 15:45:30', 'u2', 'c2'),
    ('ui120', 'comment', '2024-07-28 17:30:20', 'u2', 'c42'),
    ('ui121', 'comment', '2024-07-29 11:05:45', 'u2', 'c7'),
    ('ui122', 'comment', '2024-07-30 12:25:15', 'u3', 'c3'),
    ('ui123', 'comment', '2024-07-31 14:15:10', 'u3', 'c4'),
    ('ui124', 'comment', '2024-07-01 13:45:30', 'u3', 'c9'),
    ('ui125', 'comment', '2024-07-02 10:30:20', 'u3', 'c23'),
    ('ui126', 'comment', '2024-07-03 12:05:45', 'u3', 'c12'),
    ('ui127', 'comment', '2024-07-04 08:15:22', 'u3', 'c32'),
    ('ui128', 'comment', '2024-07-05 09:50:11', 'u4', 'c12'),
    ('ui129', 'comment', '2024-07-06 11:10:55', 'u4', 'c32'),
    ('ui130', 'comment', '2024-07-07 13:30:30', 'u4', 'c21'),
    ('ui131', 'comment', '2024-07-08 14:45:45', 'u4', 'c4'),
    ('ui132', 'comment', '2024-07-09 15:50:22', 'u5', 'c43'),
    ('ui133', 'comment', '2024-07-10 16:15:10', 'u5', 'c34'),
    ('ui134', 'comment', '2024-07-11 17:30:20', 'u5', 'c31'),
    ('ui135', 'comment', '2024-07-12 10:30:20', 'u5', 'c14'),
    ('ui136', 'comment', '2024-07-10 12:05:45', 'u5', 'c38'),
    ('ui137', 'comment', '2024-07-11 13:50:00', 'u5', 'c49'),
    ('ui138', 'comment', '2024-07-12 14:15:10', 'u5', 'c13'),
    ('ui139', 'share', '2024-07-01 08:00:00', 'u1', 'c2'),
    ('ui140', 'share', '2024-07-01 12:30:00', 'u1', 'c9'),
    ('ui141', 'share', '2024-07-02 13:00:00', 'u1', 'c7'),
    ('ui142', 'share', '2024-07-04 14:00:00', 'u1', 'c8'),
    ('ui143', 'share', '2024-07-08 15:00:00', 'u1', 'c4'),
    ('ui144', 'share', '2024-07-06 16:00:00', 'u1', 'c6'),
    ('ui145', 'share', '2024-07-07 17:00:00', 'u1', 'c50'),
    ('ui146', 'share', '2024-07-08 18:00:00', 'u1', 'c36'),
    ('ui147', 'share', '2024-07-09 19:00:00', 'u1', 'c46'),
    ('ui148', 'share', '2024-07-10 20:00:00', 'u1', 'c32'),
    ('ui149', 'share', '2024-07-11 21:00:00', 'u1', 'c43'),
    ('ui150', 'share', '2024-07-12 22:00:00', 'u1', 'c45'),
    ('ui151', 'share', '2024-07-13 23:00:00', 'u1', 'c28'),
    ('ui152', 'share', '2024-07-17 09:00:00', 'u1', 'c49'),
    ('ui153', 'share', '2024-07-15 10:00:00', 'u1', 'c34'),
    ('ui154', 'share', '2024-07-06 11:00:00', 'u1', 'c26'),
    ('ui155', 'share', '2024-07-01 12:30:00', 'u1', 'c12'),
    ('ui156', 'share', '2024-07-02 13:45:00', 'u1', 'c23'),
    ('ui157', 'share', '2024-07-15 14:00:00', 'u1', 'c38'),
    ('ui158', 'share', '2024-07-02 15:30:00', 'u2', 'c34'),
    ('ui159', 'share', '2024-07-01 16:45:00', 'u2', 'c45'),
    ('ui160', 'share', '2024-07-12 17:00:00', 'u2', 'c21'),
    ('ui161', 'share', '2024-07-12 18:15:00', 'u2', 'c2'),
    ('ui162', 'share', '2024-07-02 19:30:00', 'u2', 'c4'),
    ('ui163', 'share', '2024-07-05 20:00:00', 'u2', 'c25'),
    ('ui164', 'share', '2024-07-26 21:00:00', 'u2', 'c32'),
    ('ui165', 'share', '2024-07-27 22:00:00', 'u2', 'c2'),
    ('ui166', 'share', '2024-07-28 23:00:00', 'u2', 'c42');


update subscription set movielimit = 20 where subscriptionType = 'basic';
update subscription set movielimit = 35 where subscriptionType = 'gold';
update subscription set movielimit = 50 where subscriptionType = 'premium';


    select * from award;
    select * from content;
    select * from content_award;
    select * from content_genre;
    select * from content_persons;
    select * from creditCard;
    select * from genre;
    select * from giftCard;
    select * from media;
    select * from persons;
    select * from subscription;
    select * from tvseries;
    select * from user;
    select * from user_content;
    select * from userInteractions;




 -- procedure
delimiter &&
create procedure checkwatchecount()
begin 
   select COUNT(userInteractions.interactionType) ,content.title
from content
inner join userInteractions on content.contentID = userInteractions.contentID
where interactionType ='Watched' GROUP BY content.title;
end &&
delimiter ;

call checkwatchecount();


delimiter &&
create procedure checklikeecount()
begin 
   select COUNT(userInteractions.interactionType) ,content.title
from content
inner join userInteractions on content.contentID = userInteractions.contentID
where interactionType ='like' GROUP BY content.title;
end &&
delimiter ;

call checklikeecount();


delimiter &&
create procedure insertdatauser(userID varchar(20), username varchar(50), password varchar(50), email varchar(50) , subscriptionID varchar(20))
begin 
     insert into user () values(userID,username,password,email,subscriptionID);
end&&
delimiter ;

call insertdatauser('u9','daham9','password86','daham@exampleemail.com','sub1');


--      DELIMITER //
-- CREATE PROCEDURE CheckInteractionLimit(IN p_userID VARCHAR(20))
-- BEGIN
--     DECLARE v_movielimit INT;
--     DECLARE v_interactions_count INT;

    
--     SELECT subscription.movielimit INTO v_movielimit
--     FROM user u
--     JOIN subscription  ON user.subscriptionID = subscription.subscriptionID
--     WHERE u.userID = p_userID;


--     SELECT COUNT(*) INTO v_interactions_count
--     FROM userInteractions
--     WHERE userID = p_userID;

 
--     IF v_interactions_count >= v_movielimit THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'User has exceeded their interaction limit.';
--     END IF;
-- END //

-- DELIMITER ;

-- DELIMITER //

-- CREATE TRIGGER before_user_interaction_insert
-- BEFORE INSERT ON userInteractions
-- FOR EACH ROW
-- BEGIN
--     CALL CheckInteractionLimit(NEW.userID);
-- END //

-- DELIMITER ;




-- reportquery

select * from content where content.contentID in 
(select content_award.contentID from content_award where content_award.awardID = 
(select awardID from award where awardName= 'Academy Best Picture') );

select COUNT(userInteractions.interactionType) ,content.title
from content
inner join userInteractions on content.contentID = userInteractions.contentID
where interactionType ='Watched' GROUP BY content.title;



select genre.genreName,content.title,content.contentID
from content
inner join content_genre on content.contentID = content_genre.contentID
inner join genre on  content_genre.genreID = genre.genreID;



select userInteractions.interactionType,content.title,user.username 
from content
inner join userInteractions on userInteractions.contentId = content.contentId
inner join user on userInteractions.userID = user.userID ; 



select award.awardName,content.title,content_award.recievedDate
from content
inner join content_award on content.contentID = content_award.contentID
inner join award on award.awardID = content_award.awardID
where title='Titanic';



select user.userID,content.title, userInteractions.interactionType
from content
inner join userInteractions on content.contentID = userInteractions.contentID
inner join user on user.userID = userInteractions.userID
where interactionType ='Watched' and userInteractions.userID='u1';



select content.contentID,content.title, persons.firstName, persons.lastName , persons.personType
from content
inner join content_persons on content.contentID = content_persons.contentID
inner join persons on persons.personID = content_persons.personID
where personType='Director';

-- top 10 popular content
select content.title, count( user_content.contentID) as watch_count
from content 
inner join user_content  on content.contentID = user_content.contentID
group by content.title
order by watch_count desc
limit 10;

-- revenue
select subscription.subscriptionType, count(user.userID) * subscription.price as revenue
from subscription 
inner join user  on subscription.subscriptionID = user.subscriptionID
group by subscription.subscriptionType, subscription.price;



-- view
create view userpayment as select user.userID, user.username, creditCard.cardNumber, creditCard.expiryDate, creditCard.cvv from user , creditCard  where user.userID = creditCard.userID;
select * from userpayment;

CREATE VIEW usergiftcard AS
SELECT user.userID, user.username, giftCard.giftCardID, giftCard.amount,giftCard.expiryDate
FROM user INNER JOIN giftCard ON user.userID = giftCard.userID;
SELECT * FROM usergiftcard;