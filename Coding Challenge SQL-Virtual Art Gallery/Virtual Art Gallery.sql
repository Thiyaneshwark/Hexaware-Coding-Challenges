create database [Virtual Art Gallery];
use [Virtual Art Gallery];

-- creating the Artists table
create table Artists (
ArtistID int primary key,
Name varchar(150) not null,
Biography text,
Nationality varchar(100)
);

-- creating the Categories table
create table Categories (
CategoryID int primary key,
Name varchar(100) not null unique  
);

-- creating the Artworks table
create table Artworks (
ArtworkID int primary key,
Title varchar(255) not null,
ArtistID int not null,  
CategoryID int,
Year int,
Description text,
ImageURL varchar(255),
Price decimal(10, 2),  
Status varchar(50) default 'Available', 
foreign key (ArtistID) references Artists (ArtistID) on delete cascade on update cascade,  
foreign key (CategoryID) references Categories (CategoryID) on delete set null on update cascade  
);

-- creating the Exhibitions table
create table Exhibitions (
ExhibitionID int primary key,
Title varchar(255) not null,
StartDate date not null,
EndDate date not null,
Location varchar(255) not null,  
Description text
);

-- creating the ExhibitionArtworks table
create table ExhibitionArtworks (
ExhibitionID int,
ArtworkID int,
foreign key (ExhibitionID) references Exhibitions (ExhibitionID) on delete cascade on update cascade,  
foreign key (ArtworkID) references Artworks (ArtworkID) on delete cascade on update cascade, 
primary key (ExhibitionID, ArtworkID)
);

-- Inserting data's into the Artists table
insert into Artists (ArtistID, Name, Biography, Nationality) values
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian'),
(4, 'Andy Warhol', 'American artist and a leading figure in the visual art movement known as Pop Art.', 'American');

-- Inserting data's into the Categories table
insert into Categories (CategoryID, Name) values
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Photography');

-- Inserting data's into the Artworks table
insert into Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL, Price, Status) values
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg', 1000000, 'Available'),
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg', 2000000, 'Available'),
(3, 'Guernica', 1, 1, 1937, 'Pablo Picassos powerful anti-war mural.', 'guernica.jpg', 500000, 'Sold'),
(4, 'Les Demoiselles Avignon', 1, 1, 1907, 'A landmark painting by Pablo Picasso.', 'les_demoiselles.jpg',20000,'sold'),
(5, 'The Night Café', 2, 1, 1888, 'A famous painting by Vincent van Gogh.', 'night_cafe.jpg',2100000,'sold'),
(6, 'The Persistence of Memory', 1, 1, 1931, 'A surreal painting by Salvador Dalí.', 'persistence_of_memory.jpg',900000,'Available'),
(7, 'Self-Portrait with Bandaged Ear', 2, 1, 1889, 'A self-portrait by Vincent van Gogh.', 'self_portrait.jpg',76000,'Available'),
(8, 'The Dance', 1, 1, 1910, 'A painting by Pablo Picasso.', 'the_dance.jpg',700000,'Available'),
(9, 'The Weeping Woman', 1, 1, 1937, 'A painting by Pablo Picasso.', 'weeping_woman.jpg',60000,'sold'),
(10, 'Café Terrace at Night', 2, 1, 1888, 'A painting by Vincent van Gogh.', 'cafe_terrace.jpg',690000,'Available'),
(11, 'The Starry Night Over the Rhône', 2, 2, 1888, 'Another painting by Vincent van Gogh in a different category.', 'starry_night_rhone.jpg',120000,'sold'),
(12, 'Vitruvian Man', 3, 3, 1490, 'A drawing by Leonardo da Vinci representing ideal human proportions.', 'vitruvian_man.jpg',100000,'Available'),
(13, 'The Weeping Woman', 1, 2, 1937, 'A painting by Pablo Picasso.', 'weeping_woman_2.jpg',120000,'sold'),
(14, 'Campbells Soup Cans', 4, 1, 1962, 'A famous work by Andy Warhol featuring soup cans.', 'campbell_soup_cans.jpg', 1000000, 'Available'), 
(15, 'Brillo Boxes', 4, 2, 1964, 'Sculptural artwork by Andy Warhol.', 'brillo_boxes.jpg', 500000, 'Available'), 
(16, 'Self-Portrait', 4, 3, 1986, 'A photographic self-portrait by Andy Warhol.', 'self_portrait_warhol.jpg', 300000, 'Available');  

-- Inserting data's into the Exhibitions table
insert into Exhibitions (ExhibitionID, Title, StartDate, EndDate, Location, Description) values
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'New York', 'A collection of modern art masterpieces.'),
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'Paris', 'A showcase of Renaissance art treasures.');

-- Inserting data's into the Exhibitionsartworks table
insert into ExhibitionArtworks (ExhibitionID, ArtworkID) values
(1, 1),
(1, 2),
(1, 3),
(2, 2);

-- 1. Retrieve the names of all artists along with the number of artworks they have in the gallery, 
--and list them in descending order of the number of artworks.
select a.Name, count(aw.ArtworkID) as [Art work Count]
from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
group by a.Name
order by [Art work Count] desc;

-- 2. List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, 
--and order them by the year in ascending order.
select aw.Title
from Artworks aw
join Artists a on aw.ArtistID = a.ArtistID
where a.Nationality in ('Spanish', 'Dutch')
order by aw.Year asc;

-- 3. Find the names of all artists who have artworks in the 'Painting' category and the number of artworks they have in this category.
select a.Name, count(aw.ArtworkID) as ArtworkCount
from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
where aw.CategoryID = (select CategoryID from Categories where Name = 'Painting')
group by a.Name;

-- 4. List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their artists and categories.
select aw.Title, a.Name as ArtistName, c.Name as CategoryName
from Artworks aw
join Artists a on aw.ArtistID = a.ArtistID
join Categories c on aw.CategoryID = c.CategoryID
join ExhibitionArtworks ea on aw.ArtworkID = ea.ArtworkID
join Exhibitions e on ea.ExhibitionID = e.ExhibitionID
where e.Title = 'Modern Art Masterpieces';

-- 5. Find the artists who have more than two artworks in the gallery.
select a.Name
from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
group by a.Name
having count(aw.ArtworkID) > 2;

-- 6. Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' 
--and 'Renaissance Art' exhibitions.
select aw.title as Title
from artworks aw
join exhibitionartworks ea on aw.artworkid = ea.artworkid
join exhibitions e on ea.exhibitionid = e.exhibitionid
where e.title in ('Modern Art Masterpieces', 'Renaissance Art')
group by aw.title
having count(e.title) = 2;

-- 7. Find the total number of artworks in each category.
select c.Name as CategoryName, count(aw.ArtworkID) as ArtworkCount
from Categories c
join Artworks aw on c.CategoryID = aw.CategoryID
group by c.Name;

-- 8. List artists who have more than 3 artworks in the gallery.
select a.Name
from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
group by a.Name
having count(aw.ArtworkID) > 3;

-- 9. Find the artworks created by artists from a specific nationality (e.g., Spanish).
select aw.Title
from Artworks aw
join Artists a on aw.ArtistID = a.ArtistID
where a.Nationality = 'Spanish';

-- 10. List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci.
select e.Title
from Exhibitions e
join ExhibitionArtworks ea on e.ExhibitionID = ea.ExhibitionID
join Artworks aw on ea.ArtworkID = aw.ArtworkID
join Artists a on aw.ArtistID = a.ArtistID
where a.Name in ('Vincent van Gogh', 'Leonardo da Vinci')
group by e.Title
having count(distinct a.Name) = 2;

-- 11. Find all the artworks that have not been included in any exhibition.
select aw.Title
from Artworks aw
left join ExhibitionArtworks ea on aw.ArtworkID = ea.ArtworkID
where ea.ExhibitionID is null;

-- 12. List artists who have created artworks in all available categories.
select a.Name
from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
group by a.Name
having count(distinct aw.CategoryID) = (select count(*) from Categories);

-- 13. List the total number of artworks in each category.
select c.Name, count(aw.ArtworkID) as [Art work Count]
from Categories c
join Artworks aw on c.CategoryID = aw.CategoryID
group by c.Name;

-- 14. Find the artists who have more than 2 artworks in the gallery.
select a.Name
from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
group by a.Name
having count(aw.ArtworkID) > 2;

-- 15. List the categories with the average year of artworks they contain, only for categories with more than 1 artwork.
select c.Name as [Category Name], avg(aw.Year) as [Average Year]
from Categories c
join Artworks aw on c.CategoryID = aw.CategoryID
group by c.Name
having count(aw.ArtworkID) > 1;

-- 16. Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition
select aw.Title
from Artworks aw
join exhibitionartworks ea on aw.ArtworkID = ea.ArtworkID
where ea.ExhibitionID = (select ExhibitionID from Exhibitions where Title = 'Modern Art Masterpieces');

-- 17. Find the categories where the average year of artworks is greater than the average year of all artworks.
select c.Name as [Category Name]
from Categories c
join Artworks aw on c.CategoryID = aw.CategoryID
group by c.Name
having avg(aw.Year) > (select avg(Year) from Artworks);

-- 18. List the artworks that were not exhibited in any exhibition.
select aw.Title
from Artworks aw
left join ExhibitionArtworks ea on aw.ArtworkID = ea.ArtworkID
where ea.ExhibitionID is null;

-- 19. Show artists who have artworks in the same category as 'Mona Lisa.'
select a.Name
from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
where aw.CategoryID = (select CategoryID from Artworks where Title = 'Mona Lisa');

-- 20. List the names of artists and the number of artworks they have in the gallery.
select a.Name, count(aw.ArtworkID) as [Art work Count]
from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
group by a.Name;






