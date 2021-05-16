-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 09, 2019 at 09:15 AM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jingle_final`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `split_string` ()  BEGIN
 
DECLARE my_delimiter CHAR(1);
DECLARE split_string VARCHAR(255);
DECLARE done INT;
DECLARE occurance INT;
DECLARE i INT;
DECLARE ins_query VARCHAR(500);
DECLARE tmp_query VARCHAR(500);
DECLARE splitter_cur CURSOR FOR
SELECT artist FROM jingle_final.music;
 
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
 
OPEN splitter_cur;
splitter_loop:LOOP
      FETCH splitter_cur INTO split_string;
 
SET occurance=LENGTH(split_string)-LENGTH(REPLACE(split_string,',',''))+1;
SET my_delimiter=',';
  IF done=1 THEN
    LEAVE splitter_loop;
  END IF;
#  select occurance;
  IF occurance > 0 THEN
    #select occurance;
    SET i=1;
    WHILE i <= occurance DO
#        select concat("SUBSTRING_INDEX(SUBSTRING_INDEX( '",split_string ,"', '",my_delimiter,"', ",i, "),'",my_delimiter,"',-1);");
        SET ins_query=CONCAT("insert into jingle_final.temp(splitted_columns) values(", CONCAT("SUBSTRING_INDEX(SUBSTRING_INDEX( '",split_string ,"', '",my_delimiter,"', ",i, "),'",my_delimiter,"',-1));"));
        SET @ins_query=ins_query;
        PREPARE ins_query FROM @ins_query;
        EXECUTE ins_query;
      SET i=i+1;
    END WHILE;
  ELSE
        SET ins_query=CONCAT("insert into jingle_final.temp(splitted_columns) values(",split_string,"');");
        SET @ins_query=ins_query;
        PREPARE ins_query FROM @ins_query;
        EXECUTE ins_query;
  END IF;
  SET occurance=0;
END LOOP;
 
CLOSE splitter_cur;
 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image_path` text,
  `desc` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`, `image_path`, `desc`) VALUES
(4, 'Atif Aslam', 'images/Atif Aslam (2).jpg', '         Muhammad Atif Aslam (born 12 March 1983) is a Pakistani playback singer and actor.His movie debut was the 2011 social drama Bol. He has recorded numerous chart-topping songs[4] and is known for his vocal belting technique.[5] He predominantly sings in Urdu and Punjabi, but has also sung in Bengali. He is a recipient of numerous Lux Style Awards, he also received Tamgha-e-Imtiaz in 2008, the fourth-highest decoration given to civilians in Pakistan.[6]     	              '),
(6, 'Srinam', 'images/sriram.jpg', 'Sid Sriram (born 19 May 1990) is an American music producer, playback singer, and song writer of Indian Tamil origin. He is a R&B songwriter, singer and performer, and works in the Tamil, Telugu film industries. He regularly collaborates with Bharata Natyam dancer, Pallavi Sriram, his sister, and music director A. R.'),
(7, 'Ash King', 'images/ash king.jpg', 'Ash King (born Ashutosh Ganguly) is a singer, songwriter and composer of Bengali origin based in London. He made his playback singing debut in Rakeysh Omprakash Mehra''s Delhi-6.[1][2] He is a relative of prominent Bengali singer Kishore Kumar.\r\nAsh King hails from a family of musicians who has shaped his relationship with music. His grandfather Brajendra Lal Ganguly was the first Indian classical music teacher at Nobel laureate Rabindranath Tagore''s home and school Shantiniketan, and also a prominent freedom fighter for India and close ally of Subhas Chandra Bose and first cousin of Kishore Kumar''s father.[3] King spent his childhood surrounded by celebrated musical artists with whom his father worked closely with. Music has always run in his family.'),
(8, 'Sachin Jigar', 'images/sachin jigar.jpg', 'Sachin–Jigar is a music composer duo from Mumbai, India, consisting of Sachin Sanghvi and Jigar Saraiya. They compose for Bollywood and Gujarati movies. They have scored a number of successful soundtracks. Before working independently as music director duo, they were assisting Pritam in set up musical arrangements.\r\nSachin and Jigar are Gujaratis.[1] Sachin was born on 14 June 1980 and Jigar was born on 12 April 1985. They were interested in music from childhood. Music was one of their passions but just like other children, studies and academic career overpowered it but with time they realized their love for music and followed the field judiciously.'),
(11, 'Arijit Singh', 'images/arijit_singh.jpg', 'Arijit Singh (born 25 April 1987) is an Indian playback singer, music director, score composer, music producer, recordist and music programmer.[6][4][7] He sings predominantly in Hindi and Bengali, but has also performed in various other Indian languagesl.[8][9] Singh is regarded as one of the most versatile and successful singers in the history of Indian music and Hindi cinema.[10][11][12][13]\r\n\r\nSingh made his career breakthrough after he participated in the contemporary reality show, Fame Gurukul in 2005, and was discovered by filmmaker Sanjay Leela Bhansali and Kumar Taurani.'),
(12, 'Harshdeep Kaur', 'images/harshdeep kaur.jpg', 'Harshdeep Kaur (born 16 December 1986) is an Indian Playback singer known for her Bollywood Hindi, Punjabi and Sufi songs. She is popularly known as "Sufi Ki Sultana" because of her soulful Sufi renditions.[1] After winning the titles in two talent reality shows, Kaur established herself as a lead singer in Bollywood soundtracks. She was sixteen years old when her first Bollywood song "Sajna Mai Haari" released.'),
(13, 'Armaan Malik', 'images/armaan malik.jpg', 'Armaan Malik (born 22 July 1995) is an Indian playback singer and actor.[1][2] A finalist on Zee Tv''s Sa Re Ga Ma Pa L''il Champs, Armaan advanced to eighth place with public votes. He is the brother of composer Amaal Mallik. previously represented by Universal Music India, and now signed on by T-Series.[3] His first on-screen appearance was in the film Kaccha Limboo in the year 2011.[4]'),
(14, 'Shraddha Kapoor', 'images/shradha kapor.jpg', 'Shraddha Kapoor (born 3 March 1987) is an Indian actress and singer who works in Hindi films. The daughter of actor Shakti Kapoor, she began her acting career with a brief role in the 2010 heist film Teen Patti, and followed it with her first leading role in the teen drama Luv Ka The End (2011).\r\n\r\nKapoor gained wide recognition for playing a singer in the commercially successful romantic drama Aashiqui 2 (2013), for which she received a nomination for the Filmfare Award for Best Actress. '),
(15, 'Mohit Chauhan', 'images/mohit chauhan.jpg', 'Mohit Chauhan (born 11 March 1966) is an Indian playback singer, most known for his work for Bollywood, Tollywood, & Kollywood movies. He was also part of the Indipop band Silk Route. Chauhan is a two-time recipient of the Filmfare Award for Best Male Playback Singer and three times Zee Cine Award For Best Male Playback Singer.[1] He has recorded songs for film music and albums in various Indian languages and has established himself as a leading playback singer of Indian cinema.'),
(16, 'Neha Kakkar', 'images/neha kakaar.jpg', 'Neha Kakkar (born 6 June 1988) is an Indian singer.[4] She competed on season 2 of the television reality show Indian Idol in 2006 and was a judge on the tenth season of the same show i.e. Indian Idol 10.[3] She also appeared in Comedy Circus Ke Taansen in 2014 on Sony TV. She had judged a singing reality show on Zee TV named Sa Re Ga Ma Pa Lil Champs.[5]'),
(17, 'Tarannum Mallik', 'images/tarannum malik.jpg', 'Malik began her singing career by lending her voice for the movie Biwi No.1. She went on to record her first vocal track at the age of 5. This was followed by other movies where Malik sang as a child artist, such as Mela and Badal.[2]\r\n\r\nIn the year 2006, director J.P.Dutta cast her as the singer for lead actress Aishwariya Rai in the movie Umrao Jaan. Her next release was the song "Chal Mera Hath Pakad Le" from the Satish Kaushik movie Teree Sang. During the film''s pre-release the song gained significant popularity after Malik''s impromptu live performance on the widely watched music reality show Indian Idol.[3]'),
(18, 'Aastha Gill', 'images/aashta gil.jpg', 'Aastha Gill is an Indian playback singer from Delhi. She is best known as a playback singer in Hindi films. Her Bollywood playback singing career began with the party song Dhup Chik[1] with entertainer Raftaar and Badshah from the movie Fugly in 2014.[2]\r\n\r\nShe followed it up with songs like Abhi Toh Party Shuru Hui Hai[3] from the movie Khoobsurat with Badshah. She also has a single titled DJ Waley Babu. Her latest track with Badshah is called "Nain".\r\n\r\nShe completed her bachelor''s in journalism from Delhi''s Vivekananda institute of professional studies (VIPS).'),
(19, 'Badshah', 'images/badshah.jpg', '              	Aditya Prateek Singh Sisodia, better known by his stage name Badshah,[1][2][3] is an Indian rap-music composer rapper and co-singer known for his Hindi, Haryanvi, and Punjabi songs.[4] He started his career in 2006 alongside Yo Yo Honey Singh in his Group Band Mafia Mundeer and gained spontaneous popularity among youth. He split from Honey in 2012 and gained fame with his independent Haryanvi song Kar Gayi Chull, which was later adopted into the 2016 Bollywood movie, Kapoor & Sons. His music has been featured in Bollywood soundtracks for films such as 2014 films Humpty Sharma Ki Dulhania[5] and Khoobsurat.[6]'),
(23, 'Sunidhi Chauhan', 'images/sunidhi chauhan.jpg', '           Sunidhi Chauhan (pronounced [s?n?d?i? t??o?h?n]; born 14 August 1983) is an Indian playback singer. Born in Delhi, she began performing in local gatherings at the age of 4 and made her career debut at the age of 12, with the film Shastra (1996). During the year, she won the first singing reality show titled Meri Awaz Suno and rose to prominence after recording "Ruki Ruki Si Zindagi" from Mast (1999). It won her Filmfare RD Burman Award for New Music Talent and was nominated for the Best Female Playback Singer.   	              '),
(34, 'Kumar Sanu', 'images/kumar sanu.jpg', 'Kedarnath Bhattacharya (born 23 September 1957), better known as Kumar Sanu, is a leading Indian playback singer and music director of Bengali background, popular for rendering his voice in Bollywood movies of the 1990s and early 2000s. He was awarded the Filmfare Best Male Playback Singer Award for five consecutive years. In 2009, the Government of India awarded him the Padma Shri, India''s fourth-highest civilian honour, in recognition of his achievements.[4][5] Sanu notably holds the Guinness World Record for most songs recorded by a singer in 24 hours with 28.[6]	              '),
(35, 'Udit Narayan', 'images/udit narayan.jpg', 'Udit Narayan (born 1 December 1955)[1] is an Indian playback singer whose songs have been featured mainly in Bollywood movies of Hindi language. He has also sung in various other languages including Nepali, Maithili and Bhojpuri.[5] He has won 5 National Film Awards[6][4] (of which 4 as a singer, for 2 songs in 2001, 1 each in 2002 and 2004 along with 1 as a producer in 2005) and 5 Filmfare Awards with 20 nominations among many others. He had to struggle a lot even after his debut in 1980 in Bollywood playback. He got to sing with legends Mohammed Rafi in his Bollywood Playback debut in movie Unees-Bees in 1980 and also with Kishore Kumar in the 1980s. He finally made his mark in 1988 movie Qayamat Se Qayamat Tak starring Aamir Khan and Juhi Chawla, his song "Papa Kehte Hain" was his notable performance which earned him his first Filmfare Award in the 1980s and he established himself in Bollywood Playback Singing. He is the only male singer in the history of the Filmfare Awards to have won in over three decades (the 1980s, 1990s, and 2000s).'),
(36, 'Vishal Dadlani', 'images/vishal dadlani.jpg', 'Vishal Dadlani''s musical journey started back in 1994, with the electronica/indie-rock band Pentagram formed in Mumbai. The band fronted by Vishal Dadlani (one half of the film music producing duo Vishal-Shekhar) with Randolph Correia on guitars, Clyde D''souza (former member) on guitars, Papal Mane on bass and Shiraz Bhattacharya on drums. All of whom have recently been actively involved in the Bollywood music business. Pentagram received their initial recognition and fame by winning three major rock competitions at IIT Kanpur, IIT Delhi and IIT Bombay. Of these, Livewire, the annual band competition at Mood Indigo landed them a record deal. Pentagram regarded as one of the pioneers of original Indian independent music, the band has received major recognition.[2] Pentagram has been recognized among the top rock bands of India since past 20 years.[3] Pentagram have had a brief touring history outside India; including the Sundance Music Festival in Estonia in 2003. In 2005, Pentagram became the first Indian band to play at the Glastonbury Music Festival in the UK.[4]'),
(37, 'Shalmali Kholgade', 'images/shalmali kholgade.jpg', 'Shalmali Kholgade is an Indian playback singer, who predominantly sings for the Hindi language films.[1] In addition to Hindi, she has also sung in other Indian languages such as Marathi, Bengali, Telugu and Tamil. Through her singing career, she has received one Filmfare Award from two nominations, and has been praised for her singing style.\r\nKholgade began her Bollywood playback singing career with the song "Pareshaan" for the film Ishaqzaade (2012), which earned her wide success and several awards and nominations, including the Filmfare Award for Best Female Playback Singer. The following year, she garnered a second nomination in the Best Female Playback Singer category at Filmfare for singing the song "Balam Pichkari" from the coming-of-age romance Yeh Jawaani Hai Deewani (2013) and received praise for the song "Baby Ko Bass Pasand Hai" from the sports drama Sultan (2016), both of which rank among one of the highest-grossing Bollywood film.'),
(38, 'Balraj Sahani', 'images/balrag sahani.jpg', 'Sahni was born on 1 May 1913 in Rawalpindi, British India.[2] He studied at Government College University (Lahore), Punjab, British India. After completing his master''s degree in English Literature from Lahore, he went back to Rawalpindi and joined his family business. He also held a Bachelor''s degree in Hindi.[3]Soon after, he married Damayanti Sahni.\r\n\r\nIn the late 1930s, Sahni and his wife left Rawalpindi to join Tagore''s Visva-Bharati University in Shantiniketan in Bengal as an English and Hindi teacher. It is here that their son, Parikshit Sahni was born, when his wife Damayanti was earning her bachelor''s degree.[4] He also collaborated with Mahatma Gandhi for a year in 1938. The next year, Sahni, with Gandhi''s blessings, went to England to join the BBC-London''s Hindi service as a radio announcer. He returned to India in 1943.'),
(39, 'Kishore Kumar', 'images/kishore kumar.jpg', 'Kishore Kumar (4 August 1929 – 13 October 1987) was an Indian playback singer, actor, lyricist, composer, producer, director, and screenwriter.[2] He is considered as one of the most popular and successful singers of Hindi film industry [3][4] and from soft numbers to peppy tracks to romantic moods, Kumar sang in different genres[5] but some of his rare compositions which were considered classics were lost in time.[6] According to Ashok Kumar, Kumar''s success lies in the fact that his voice used to hit the microphone straight at its most sensitive point.[7]'),
(40, 'Dharmendra', 'images/dharmendra.jpg', 'Dharam Singh Deol (born 8 December 1935) is an Indian film actor, producer and politician. In 1997, he received the Filmfare Lifetime Achievement Award for his contribution to Hindi cinema.\r\n\r\nOne of his most notable roles was in Sholay (1975).[2]\r\n\r\nHe was a member of the 14th Lok Sabha of India, representing Bikaner constituency in Rajasthan from Bharatiya Janata Party (BJP). In 2012, he was awarded India''s third-highest civilian honour Padma Bhushan by the Government of India.[3]'),
(42, 'Amitabh Bachchan', 'images/amithabh bachhan.jpg', 'Amitabh Bachchan (pronounced [?m??ta?b? ?b?t???n]; born Inquilaab Srivastava;[1] 11 October 1942) is an Indian film actor, film producer, television host, occasional playback singer and former politician. He first gained popularity in the early 1970s for films such as Zanjeer, Deewaar and Sholay, and was dubbed India''s "angry young man" for his on-screen roles in Bollywood. Referred to as the Shahenshah of Bollywood, Sadi ka Mahanayak (Hindi for, "Greatest actor of the century"), Star of the Millennium, or Big B,[4][5][6] he has since appeared in over 190 Indian films in a career spanning almost five decades.[7] Bachchan is widely regarded as one of the greatest and most influential actors in the history of Indian cinema as well as world cinema.[8][9][10][11][12] So total was his dominance on the Indian movie scene in the 1970s and 1980s that the French director François Truffaut called him a "one-man industry".'),
(43, 'Hema Malini', 'images/hema malini.jpg', 'Hema Malini (born 16 October 1948) is an Indian actress, writer, director, producer, dancer and politician.[2] In 1962, she made her acting debut in the Tamil film Ithu Sathiyam. Malini first acted in a main role in Sapno Ka Saudagar (1968), and went on to feature in numerous Bollywood films, primarily as the lead actress. In most of her films, she starred opposite her husband Dharmendra and with Rajesh Khanna and Dev Anand.[3] Malini was initially promoted as the "Dream Girl", and in 1977 starred in a film of the same name.[3] She has played both comic and dramatic roles, as well as being a dancer.[4][5][6][7] She has appeared in more than 150 films.'),
(44, 'Salman Khan', 'images/salman.jpg', 'Abdul Rashid Salim Salman Khan (pronounced [s?l?ma?n ?xa?n]; born 27 December 1965)[5] is an Indian film actor, producer, occasional singer and television personality. In a film career spanning almost thirty years, Khan has received numerous awards, including two National Film Awards as a film producer, and two Filmfare Awards for acting.[6] He has a significant following in Asia and the Indian diaspora worldwide, and is cited in the media as one of the most commercially successful actors of both world and Indian cinema.[7][8][9] According to the Forbes 2018 list of Top-Paid 100 Celebrity Entertainers in world, Khan was the highest ranked Indian with 82nd rank with earnings of $37.7 million.[3][10] He is also known as the host of the reality show, Bigg Boss since 2010.[11]'),
(45, 'Aishwarya Rai', 'images/aishwarya.jpg', 'Aishwarya Rai (born 1 November 1973), also known by her married name Aishwarya Rai Bachchan, is an Indian actress, model and the winner of the Miss World 1994 pageant. Through her successful acting career, she has established herself as one of the most popular and influential celebrities in India.[1][2] Rai has received numerous accolades, including two Filmfare Awards from eleven nominations, and she was honoured with the Padma Shri by the Government of India in 2009 and the Ordre des Arts et des Lettres by the Government of France in 2012. She has often been cited in the media as "the most beautiful woman in the world".'),
(46, 'Alka Yagnik', 'images/alka yagnik.jpg', 'Alka Yagnik (born 20 March 1966) is an Indian playback singer. She is noted in Indian cinema for a career spanning over three decades.[1] She is a record seven-time winner from a record of 36 nominations of the Filmfare Award for Best Female Playback Singer, a two-time recipient of the National Film Award[2] as well as several other music awards and honours listed below. Further, as many as twenty of her tracks feature in BBC''s "Top 40 Bollywood Soundtracks of all time" review.'),
(47, 'Anuradha Paudwal', 'images/anuradha paudwal.jpg', 'Anuradha Paudwal (born 27 October 1954) is an Indian playback singer who works in Bollywood.[2][3] She was awarded the Padma Shri,[4] India''s fourth-highest civilian award, by the Government of India in 2017.[5] She is a recipient of the National Film Award and a four-time winner of the Filmfare Award.'),
(48, 'Aamir Khan', 'images/aamir khan.jpg', 'Mohammed Aamir Hussain Khan (pronounced [?a?m?r ?xa?n]; born 14 March 1965), widely known as Aamir Khan, is an Indian film actor, director, filmmaker and television talk-show host. Through his thirty-year career in Hindi films, Khan has established himself as one of the most popular and influential actors of Indian cinema.[1][2] He has a large global following, especially in Southern Asia and Greater China, and has been described by Newsweek as "the biggest movie star" in the world.[3][4][5] Khan is the recipient of numerous awards, including nine Filmfare Awards, four National Film Awards, and an AACTA Award, as well as an Academy Award nomination. '),
(49, 'Arigit Singh', 'images/Arijit-Singh.jpg', 'Arijit Singh (born 25 April 1987) is an Indian playback singer, music director, score composer, music producer, recordist and music programmer.[6][4][7] He sings predominantly in Hindi and Bengali, but has also performed in various other Indian languagesl.[8][9] Singh is regarded as one of the most versatile and successful singers in the history of Indian music and Hindi cinema.'),
(51, 'Traevus-Owamos', 'images/Traevus owamos.jpg', 'Brigadier General Antonio J. Ramos (born 1946) was an officer of the United States Air Force. He was the first Hispanic to serve as commander, Air Force Security Assistance Center, Air Force Materiel Command, and dual-hatted as Assistant to the Commander for International Affairs, Headquarters Air Force Materiel Command.'),
(53, 'jagjit-singh', 'images/jagjit singh.jpg', 'Jagjit Singh, born Jagmohan Singh Dhiman (8 February 1941 – 10 October 2011), popularly known as "The Ghazal King" or "King of Ghazals", was an Indian Ghazal singer, composer and musician. He sang in numerous languages and is credited for the revival and popularity of ghazal, an Indian classical art form, by choosing poetry that was relevant to the masses and composing them in a way that laid more emphasis on the meaning of words and melody evoked by them. In terms of Indian Classical music, his style of composing and Gayaki (singing) is considered as Bol-pradhan, one that lays emphasis on words.'),
(54, 'Khaligraph Jones', 'images/khaligraph jones.jpg', 'Kenyan hip hop is a genre of music, and a culture that covers various forms and sub genres of hip-hop and rap originating from Kenya. It is commonly a combination of Swahili and English (Kenya''s official languages) as well as Sheng and a variety of tribal languages.'),
(55, 'Dizasta Vina', 'images/dizasta vina.jpg', 'Rudra veena (also spelled Rudra vina, and also called B?n in North India), is a large plucked string instrument, originating from the Indian subcontinent, used in Hindustani classical music, one of the major types of veena played in Indian classical music.\r\n\r\nIt has a long tubular body made of wood or bamboo with a length between 54 and 62 inches. Two large, round resonators, made of dried and hollowed gourds, are attached under the tube. '),
(56, 'Pankaj Udhas', 'images/pankaj udhas.jpg', 'Pankaj Udhas is a ghazal singer, hailing from Gujarat in India. He started his career with a release of a ghazal album titled Aahat in 1980 and subsequently recorded many hits like Mukarar in 1981, Tarrannum in 1982, Mehfil in 1983, Pankaj Udhas Live at Royal Albert Hall in 1984, Nayaab in 1985 and Aafreen in 1986. After his success as a ghazal singer, he was invited to appear and sing for a film by Mahesh Bhatt, Naam. Udhas rose to further fame for singing in the 1986 film Naam, in which his song "Chitthi Aayee Hai" became an instant hit. '),
(58, 'Niranjan Pandya', 'images/niranjan pandya.jpg', 'Niranjan Pranshankar Pandya is an Indian blind social worker[1] and the secretary of Poona Blind Mens'' Association, a non governmental organization[2] working for the cause of visually impaired people of Pune and neighbouring areas.[3] He was honored by the Government of India, in 2012, with the fourth highest Indian civilian award of Padma Shri.');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` text,
  `image_path` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image_path`) VALUES
(2, 'Festivals', 'images/festivals.jpg'),
(3, 'Rock', 'images/rock.jpg'),
(4, 'Romance', 'images/romance.jpg'),
(5, 'Sufi', 'images/sufi.jpg'),
(6, 'Hip Hop', 'images/hip_hop.jpg'),
(7, 'Ghazal', 'images/ghazal.jpg'),
(8, 'Party', 'images/party.jpg'),
(11, 'Bhakti', 'images/bhakti.jpg'),
(12, 'Garba', 'images/garba.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `favourite`
--

CREATE TABLE `favourite` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `music_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `favourite`
--

INSERT INTO `favourite` (`id`, `user_id`, `music_id`) VALUES
(9, 7, 3),
(10, 7, 10),
(12, 7, 39),
(13, 9, 2),
(16, 7, 52),
(18, 7, 4),
(19, 7, 2);

-- --------------------------------------------------------

--
-- Table structure for table `music`
--

CREATE TABLE `music` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `artist` text NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `album` text,
  `audio_path` text,
  `video_url` text,
  `type` text,
  `image_path` text,
  `lyrics` text,
  `date_added` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `music`
--

INSERT INTO `music` (`id`, `name`, `artist`, `category_id`, `album`, `audio_path`, `video_url`, `type`, `image_path`, `lyrics`, `date_added`) VALUES
(2, 'Pal', 'Arigit Singh', 4, 'Jalebi', 'audio/Pal.mp3', 'https://www.youtube.com/watch?v=rIs27QjFjHk', 'new_release', 'images/pal.jpg', 'Hmm…\r\n\r\nPal ek pal mein hi tham sa gaya<br/>\r\nTu haath mein haath jo de gaya<br/>\r\nChalun main jahaan jaaye tu<br/>\r\nDaayein main tere, baayein tu<br/>\r\nHoon rut main, hawayein tu<br/>\r\nSaathiya<br/>\r\n\r\nHansu main jab gaaye tu<br/>\r\nRoun main murjhaaye tu<br/>\r\nBheegun main barsaaye tu<br/>\r\nSaathiya<br/>\r\n<br/>\r\nSaaya mera hai teri shakal<br/>\r\nHaal hai aisa kuch aajkal<br/>\r\nSubah main hoon tu dhoop hai<br/>\r\nMain aaina hoon tu roop hai<br/>\r\nYeh tera saath khoob hai<br/>\r\nHumsafar<br/>\r\n<br/>\r\nTu ishq ke saare rang de gaya<br/>\r\nPhir kheench ke apne sang le gaya<br/>\r\nKahin pe kho jaaye chal<br/>\r\nJahaan ruk jaaye pal<br/>\r\nKabhi naa phir aaye kal<br/>\r\nSaathiya<br/>\r\n<br/>\r\nEk maange agar sau khwaab doon<br/>\r\nTu rahe khush, main aabad hoon<br/>\r\nTu sabse juda juda sa hai<br/>\r\nTu apni tarah tarah sa hai<br/>\r\nMujhe lagta nahi hai tu doosra<br/>\r\n<br/>\r\nPal ek pal mein hi tham sa gaya<br/>\r\nTu haath mein haath jo de gaya<br/>\r\nChalun main jahaan jaaye tu<br/>\r\nDaayein main tere, baayein tu<br/>\r\nHoon rut main, hawayein tu<br/>\r\nSaathiya<br/>\r\n<br/>\r\nHansu main jab gaaye tu<br/>\r\nRoun main murjhaaye tu<br/>\r\nBheegun main barsaaye tu<br/>\r\nSaathiya ho.. mm..<br/>\r\nmmm..', '2019-03-08'),
(3, 'Bom Diggy', 'Zack Knight', 4, 'Sonu Ke Titu Ki Sweety', 'audio/Bom Diggy.mp3', 'https://www.youtube.com/watch?v=RI7BvTiaXwU', 'trending', 'images/bom_diggy.jpg', 'Boy you dont have to be the last one standin<br/>\r\nBoy show me, you could be the one, one, one<br/>\r\n<br/>\r\nTu ankhiyaan mila ke<br/>\r\nAa mere kol aaja<br/>\r\nIshq diyan gallan<br/>\r\nTu mennu samjha ja<br/>\r\n<br/>\r\nTu gallan badi karda<br/>\r\nVe kar ke vakha jaa<br/>\r\nNedhe nedhe aa tu aaja<br/>\r\nSohneya-ya-ya<br/>\r\n<br/>\r\nI wanna see you<br/>\r\nWalk like Rihanna<br/>\r\nGet all the pounder<br/>\r\nBom diggy diggy bom bom<br/>\r\nShe burn it up like the summer<br/>\r\nShe tell me I m rid of<br/>\r\nBom diggy diggy bom bom<br/>\r\n<br/>\r\nYou ve got me like crazy<br/>\r\nThat you call to me<br/>\r\nBom diggy diggy bom bom<br/>\r\nYou’ve got me like crazy<br/>\r\nThat you call to me<br/>\r\nBom diggy diggy bom bom<br/>\r\n\r\n', '2019-03-21'),
(4, 'Baarish', ' Ash King,Shashaa Tirupati', 4, 'Half Girlfriend', 'audio/Baarish.mp3', 'https://www.youtube.com/watch?v=BNfAf4To73c', 'most_popular', 'images/baarish.jpg', 'Chehre mein tere<br/>\r\nKhud ko main dhoondhun<br/>\r\nAankhon ke darmiyaan<br/>\r\nTu ab hai iss tarah<br/>\r\nKhwabon ko bhi jagah na mile<br/>\r\n<br/>\r\nYeh mausam ki baarish<br/>\r\nYeh baarish ka paani<br/>\r\nYeh paani ki boondein<br/>\r\nTujhe hi toh dhoondhe<br/>\r\nYeh milne ki khwahish<br/>\r\nYeh khwahish puraani<br/>\r\nHo poori tujhi se<br/>\r\nMeri yeh kahaani<br/>\r\n<br/>\r\nKabhi tujhme utrun<br/>\r\nToh saanson se guzrun<br/>\r\nToh aaye dil ko raahat<br/>\r\n<br/>\r\nMain hoon bethikana<br/>\r\nPanaah mujhko paana<br/>\r\nHai tujhme, de ijazat<br/>\r\n<br/>\r\nNa koi darmiyaan<br/>\r\nHum dono hai yahan<br/>\r\nPhir kyun hai tu bata<br/>\r\nFaasley…<br/>\r\n\r\nYeh mausam ki baarish<br/>\r\nYeh baarish ka paani<br/>\r\nYeh paani ki boondein<br/>\r\nTujhe hi toh dhoondhe<br/>\r\nYeh milne ki khwahish<br/>\r\nYeh khwahish puraani<br/>\r\nHo poori tujhi se<br/>\r\nMeri yeh kahaani<br/>\r\n<br/>\r\nNa na… la la..<br/>\r\n<br/>\r\nHawaaon se tera pata poochta hoon<br/>\r\nAb toh aaja tu kahin se<br/>\r\nParindon ki tarah yeh dil hai safar me<br/>in\r\nTu mila de zindagi se<br/>\r\n<br/>\r\nBas itni ilteja<br/>\r\nTu aake ik dafa<br/>\r\nJo dil ne na kahaa<br/>\r\nJaan le…<br/>\r\n\r\nYeh mausam ki baarish<br/>\r\nYeh baarish ka paani<br/>\r\nYeh paani ki boondein<br/>\r\nTujhe hi toh dhoondhe<br/>\r\nYeh milne ki khwahish<br/>\r\nYeh khwahish purani<br/>\r\nHo poori tujhi se<br/>\r\nMeri yeh kahaani<br/>', '2019-03-22'),
(6, 'Dekhte Dekhte', 'Atif Aslam', 4, 'Batti Gul Meter Chalu', 'audio/Dekhte_Dekhte.m4a', 'https://www.youtube.com/watch?v=Ydp5fLbxUbk', 'new_release', 'images/dekhte_dekhte.jpg', 'Rajj ke rulaaya<br/>\r\nRajj ke hansaya<br/>\r\nMaine dil kho ke ishq kamaaya<br/>\r\nMaanga jo usne ek sitara<br/>\r\nHumne zameen pe chaand bulaaya<br/>\r\n<br/>\r\nJo aankhon se… haaye<br/>\r\nWo jo aankhon se ikk pal na ojhal huve<br/>\r\nWo jo aankhon se ikk pal na ojhal huve<br/>\r\nLaapata ho gaye dekhte dekhte<br/>\r\n<br/>\r\nSochta hoon...<br/>\r\nSochta hoon ke woh kitne masoom thhe<br/>\r\nSochta hoon ke woh kitne masoom thhe<br/>\r\nKya se kya ho gaye dekhte dekhte<br/>\r\n<br/>\r\nSochta hoon ke woh kitne masoom thhe<br/>\r\nKya se kya ho gaye dekhte dekhte<br/>\r\n<br/>\r\nSochta hoon ke wo kitne masoom thhe<br/>\r\nSochta hoon ke wo kitne masoom thhe<br/>\r\nKya se kya ho gaye dekhte dekhte<br/>\r\n<br/>\r\nWo jo kehte the bichhdenge na hum kabhi<br/>\r\nWo jo kehte the bichhdenge na hum kabhi<br/>\r\nAlvida ho gaye dekhte dekhte<br/>\r\nSochta hoon…<br/>\r\n<br/>\r\nEk main ek wo, aur shaamein kayi<br/>\r\nChaand roshan thhe tab aasmaan mein kayi<br/>\r\nEk main ek woh, aur shaamein kayi<br/>\r\nChaand roshan the tab aasmaan mein kayi<br/>\r\n<br/>\r\nYaariyon ka wo dariya utar bhi gaya<br/>\r\nAur haathon mein bas ret hi reh gayi<br/>\r\n<br/>\r\nKoi puche ke.. haaye<br/>\r\nKoi puche ke humse khata kya hui<br/>\r\nKyun khafa ho gaye dekhte dekhte<br/>\r\n<br/>\r\nAate jaate thhe jo saans ban ke kabhi<br/>\r\nAate jaate thhe jo saans ban ke kabhi<br/>\r\nWoh hawa ho gaye dekhte dekhte<br/>\r\nWoh hawa ho gaye.. haaye..<br/>\r\nOh ho ho..<br/>\r\nOh ho ho..<br/>\r\n\r\nWoh hawa ho gaye dekhte dekhte<br/>\r\nAlvida ho gaye dekhte dekhte<br/>\r\nLapata ho gaye dekhte dekhte<br/>\r\nKya se kya ho gaye dekhte dekhte<br/>\r\n<br/>\r\nJeene marne ki hum the wajah aur hum hi<br/>\r\nJeene marne ki hum the wajah aur hum hi<br/>\r\nBewajah ho gaye dekhte dekhte..<br/>\r\n<br/>\r\nSochta hoon…<br/>\r\nSochta hoon ke woh kitne masoom thhe<br/>\r\nSochta hoon ke woh kitne masoom thhe<br/>\r\nKya se kya ho gaye dekhte dekhte<br/>\r\nKya se kya ho gaye dekhte dekhte<br/>\r\nKya se kya ho gaye.. oh ho ho..', '2019-03-26'),
(8, 'Tera Hua', 'Atif Aslam', 4, 'Loveratri', 'audio/tera_hua.mp3', 'https://www.youtube.com/watch?v=-4JV4hur1PM', 'new_release', 'images/tera_hua.jpg', 'Tere kareeb aa raha hun</br>\r\nKhud se main door jaa raha hun</br>\r\nYeh bewajah toh nahin</br>\r\nTu jo mila</br>\r\nDheere dheere se tera hua</br>\r\nHaule haule se tera hua</br>\r\nRafta rafta tera hua</br>\r\nTere bin main hun benishaan</br>\r\nSamjho zara samjho ishara</br>\r\nTera hun main saara ka saara</br>\r\nJaise mujhe tumse hua hai</br>\r\nYeh pyaar na hoga dobara</br>\r\nDil mein teri jo jagah hai</br>\r\nUski koi toh wajah hai</br>\r\nYeh bewajah toh nahin</br>\r\nTu jo mila</br>\r\nDheere dheere se tera hua</br>\r\nHaule haule tera hua</br>\r\nRafta rafta tera hua</br>\r\nTere bin main hun benishaan', '2019-03-08'),
(10, 'Subhanallah', 'Sreenam', 4, 'Yeh Javani He Diwani', 'audio/subhanallah.mp3', 'https://www.youtube.com/watch?v=QYO6AlxiRE4', 'trending', 'images/subhanallah.jpg', '	Ek Din Kabhi Jo Khud Ko Taraashe</br>\r\n			Meri Nazar Se Tu Zara, Haaye Re </br>\r\n			Aankhon Se Teri Kya Kya Chhupa Hai</br>\r\n			Tujhko Dikhaaun Main Zara, Haaye Re</br>\r\n			Ik Ankahi Si Daastaan Daastaan</br>\r\n			Kehne Lagega Aaina Subhanallah...</br>\r\n			Jo Ho Raha Hain Pehli Dafaa Hai Wallah</br>\r\n			Aisa Hua, Subhanallah..</br>\r\n			Jo Ho Raha Hai Pehli Dafaa Hai Wallah</br>\r\n			Aisa Hua</br>\r\n			Meri Khamoshi Se Baatein Chun Lena</br>\r\n			Unki Dori Se Taarifein Bun Lena (X2)</br>\r\n			Kal Nahi Thi Jo Aaj Lagti Hoon</br>\r\n			Taareef Meri Hai Khaamakha</br>\r\n			Tohfa Hai Tera Meri Adaa</br>\r\n			Ek Din Kabhi Jo Khud Ko Pukaare</br>\r\n			Meri Zubaan Se Tu Zara, Haaye Re</br>\r\n			Tujh Mein Chhupi Si Jo Shayari Hai</br>\r\n			Tujhko Sunaaun Main Zara, Haay Re</br>\r\n			Ye Do Dilon Ka Waasta Waasta</br>\r\n			Khul Ke Bataaya Jaaye Naa </br>\r\n			Subhanallah...</br>\r\n			Jo Ho Raha Hai, Pehli Dafaa Hai Wallah</br>\r\n			Aisa Hua.. Subhanallah (X3)</br>\r\n			Jo Ho Raha Hai, Pehli Dafaa Hai Wallah</br>\r\n			Aisa Hua..		', '2019-03-08'),
(13, 'Zaalima', 'Arijit Singh,Harshdeep Kaur', 4, 'Raees', 'audio/zaalima.mp3', 'https://www.youtube.com/watch?v=lpdRqn6xwiM', 'most_popular', 'images/zaalima.jpg', 'Jo teri khatir tadpe pehle se hi</br>\r\n		Kya usse tadpana o zaalima, o zaalima</br>\r\n		Jo tere ishq mein behka pehle se hi</br>\r\n		Kya usse behkana o zaalima, o zaalima (x2)</br>\r\n\r\n		Aankhen marhaba, baatein marhaba</br>\r\n		Main sau martaba deewana hua</br>\r\n		Mera na raha jab se dil mera</br>\r\n		Tere husn ka nishana hua</br>\r\n\r\n		Jiski har dhadkan tu ho aise</br>\r\n		Dil ko kya dhadkana</br>\r\n		O zaalima o zalima</br>\r\n\r\n		Jo teri khatir tadpe pehle se hi</br>\r\n		Kya usse tadpana o zaalima, o zalima</br>\r\n\r\n		Saanson mein teri nazdeekiyon ka</br>\r\n		Ittr tu ghol de.. ghol de</br>\r\n		Main hi kyun ishq zahir karun</br>\r\n		Tu bhi kabhi bol de.. bol de (x2)</br>\r\n\r\n		Leke jaan hi jaayega meri</br>\r\n		Kaatil har tera bahaana hua</br>\r\n\r\n		Tujhse hi shuru tujhpe hi khatam</br>\r\n		Mere pyaar ka fasaana hua</br>\r\n\r\n		Tu shama hai toh yaad rakhna</br>\r\n		Main bhi hoon parwana</br>\r\n		O zaalima o zalima</br>\r\n\r\n		Jo teri khatir tadpe pehle se hi</br>\r\n		Kya usse tadpana o zaalima, o zaalima</br>\r\n\r\n		Deedaar tera milne ke baad hi</br>\r\n		Chhute meri angdaayi</br>\r\n		Tu hi bata de kyu zaalima main keh layi</br>\r\n\r\n		Kyun iss tarah se duniya jahaan mein</br>\r\n		Karta hai meri ruswayi</br>\r\n		Lyrics at www.lyricsted.com</br>\r\n		Tera kasoor aur zalima main keh layi</br>\r\n\r\n		Deedaar tera milne ke baad hi</br>\r\n		Chhute meri angdaayi</br>\r\n		Tu hi bata de kyu zaalima main keh layi</br>\r\n		Tu hi bata de Kyu zaalima main keh layi', '2019-03-22'),
(15, 'Saiyaara', 'Mohit Chauhan , Tarannum Mallik', 4, 'Ek Tha Tigar', 'audio/saiyaara.mp3', 'https://www.youtube.com/watch?v=A5pSnIwbpaM', 'most_popular', 'images/saiyaara.jpg', 'Asmaan tera mera hua</br>\r\n			Khwaab ki tarah dhuaan-dhuaan</br>\r\n			Asmaan tera mera hua</br>\r\n			Saans ki tarah rooan-rooan</br>\r\n\r\n			0o jaaye jahaan tu jaaye</br>\r\n			Paaye mujhe hi paaye</br>\r\n			Saaye ye mere hain tujhme samaaye</br>\r\n\r\n			[saiyaara main saiyaara</br>\r\n			Saiyaara tu saiyaara</br>\r\n			Sitaaron ke jahaan me</br>\r\n			Milenge ab yaara] -(x2)</br>\r\n\r\n			Tu jo mila toh yuun hua</br>\r\n			Ho gayi poori adhoori si duaa</br>\r\n			Tu jo gaya toh le gaya</br>\r\n			Sang tere mere jeene ki har wajaah</br>\r\n\r\n			0o jaaye jahaan tu jaaye</br>\r\n			Paaye mujhe hi paaye</br>\r\n			Saaye ye mere hain tujhme samaaye</br>\r\n\r\n			[saiyaara main saiyaara</br>\r\n			Saiyaara tu saiyaara</br>\r\n			Sitaaron ke jahaan me</br>\r\n			Milenge ab yaara] -x2</br>\r\n\r\n			Tumpe miti tumse bani</br>\r\n			Tums ehua hai haan khudpe yakeen</br>\r\n			Tu jo nahi to naa sahi</br>\r\n			Main hoon yahaan to</br>\r\n			Tu hai yahin kahin</br>\r\n\r\n			0o jaaye jahaan tu jaaye</br>\r\n			Paaye mujhe hi paaye</br>\r\n			Saaye ye mere hain tujhme samaaye</br>\r\n\r\n			[saiyaara main saiyaara</br>\r\n			Saiyaara tu saiyaara</br>\r\n			Sitaaron ke jahaan me</br>\r\n			Milenge ab yaara] -(x2)	', '2019-03-27'),
(32, 'Buzz', 'Aastha Gill, Badshah', 8, 'Buzz (2018)', 'audio/Buzz.mp3', 'https://www.youtube.com/watch?v=dUaCEs3HfdI', NULL, 'images/buzz.jpg', 'Tujhse mann nahi hai bharta…<br/>\r\n<br/>\r\nTera buzz mujhe jeene na de<br/>\r\nJeene na de (x4)<br/>\r\n<br/>\r\nTujhse mann nahi hai bharta<br/>\r\nAb tu hi hai karta dharta<br/>\r\nTujhse mann nahi hai bharta<br/>\r\nAb tu hi hai karta dharta<br/>\r\nAur tu paani tak peene na de<br/>\r\nPeene na de…<br/>\r\n<br/>\r\nTera buzz mujhe jeene na de<br/>\r\nJeene na de (x4)<br/>\r\n<br/>\r\nTripy hain aankhein teri<br/>\r\nGhunghraale baal hain<br/>\r\nChalta jaise sab uske bapu ka maal hai<br/>\r\nChalta jaise sab uske bapu ka maal hai<br/>\r\n<br/>\r\nAur tu kamar pakad ke kheeche<br/>\r\nHaaye daiyya pairon ke neeche<br/>\r\nAur tu kamar pakad ke kheeche<br/>\r\nHaaye daiyya pairon ke neeche<br/>\r\nMere rehne tu zameene na de, meene na de<br/>\r\n<br/>\r\nTera buzz mujhe jeene na de, jeene na de (x4)<br/>\r\n(Rehne de, rehne de…)<br/>\r\n<br/>\r\n[BADSHAH RAP]<br/>\r\nOkay, okay, okay, hai maana tu hai sick<br/>\r\nJahaan se hona chaahiye wahin se hai tu thick<br/>\r\nNaa nazron mein aa, naa mujhko tu dikh<br/>\r\nMain todoonga dil tera, le kahin tu likh<br/>\r\nBaby kisi se bhi poochh, launda too much hai<br/>\r\nBoli mein thoda Haryanvi touch hai<br/>\r\nJitne bhi rumour sune tune apni saheliyon se<br/>\r\nMere baare mein woh saare sach hai<br/>\r\n<br/>\r\nBaby main hoon woh<br/>\r\nJiske baare mein<br/>\r\nChetaawani deti hogi tujhe teri maa<br/>\r\nBADshah naam badal diyo mera<br/>\r\nBaby jo naa kara di teri naa<br/>\r\n<br/>\r\nSab mujhko dekhein maine<br/>\r\nDekha tujhko bas hai<br/>\r\nSab dhundhla dhundhla laage<br/>\r\nTujhpe hi focus hai<br/>\r\nSab dhundhla dhundhla laage<br/>\r\nTujhpe hai focus!<br/>\r\n<br/>\r\nNaa dikhla tu itni tezi<br/>\r\nKarke baatein lazy lazy<br/>\r\nNaa dikhla tu itni tezi<br/>\r\nKarke baatein lazy lazy<br/>\r\nMujhko khayal kameene naa de, meene naa de<br/>\r\n<br/>\r\nTera buzz mujhe jeene na de, jeene na de..<br/>\r\n<br/>\r\nAastha Gill!<br/>\r\n<br/>\r\nIt’s you boy Badshah!<br/>\r\n<br/>\r\nTera buzz mujhe jeene na de, jeene na de…<br/>', '2019-03-27'),
(39, 'Ae watan', 'Sunidhi Chauhan', 4, 'Raazi', 'audio/Ae Watan.mp3', 'https://www.youtube.com/watch?v=YHmYop9Bc_Q', 'trending', 'images/ae_watan.jpg', 'Ae watan...<br/>\r\nMere watan...<br/>\r\n\r\nAe watan.. aabaad rahe tu<br/>\r\nAabaad rahe tu.. (aabaad rahe tu)<br/>\r\n\r\nAe watan, watan mere, aabaad rahe tu<br/>\r\nAe watan, watan mere, aabaad rahe tu<br/>\r\n(Ae watan, watan mere, aabaad rahe tu)<br/>\r\n<br/>\r\nMain jahan rahun, jahaan me yaad rahe tu<br/>\r\n(Main jahan rahun, jahaan me yaad rahe tu)<br/>\r\n<br/>\r\nAe watan… mere watan!<br/>\r\n(Ae watan… mere watan!)<br/>\r\n<br/>\r\nTu hi meri manzil hai, pehchan tujhi se<br/>\r\n(Tu hi meri manzil hai, pehchan tujhi se)<br/>\r\n<br/>\r\nPahunchu main jahaan bhi<br/>\r\nMeri buniyad rahe tu<br/>\r\n(Pahunchu main jahaan bhi<br/>\r\nMeri buniyad rahe tu)<br/>\r\n<br/>\r\nAe watan, watan mere, aabaad rahe tu<br/>\r\nMain jahan rahun, jahaan me yaad rahe tu<br/>\r\nAe watan… mere watan!<br/>\r\n(Ae watan… mere watan!)<br/>\r\n<br/>\r\nTujhpe koi gham ki aanch aane nahin doon<br/>\r\n(Tujhpe koi gham ki aanch aane nahin doon)<br/>\r\n<br/>\r\nKurbaan meri jaan tujhpe, shaad rahe tu<br/>\r\n(Kurbaan meri jaan tujhpe, shaad rahe tu)<br/>\r\n<br/>\r\nAe watan, watan mere, aabaad rahe tu<br/>\r\nMain jahan rahun, jahaan me yaad rahe tu<br/>\r\nAye watan… (aye watan..)<br/>\r\nMere watan… (mere watan..)<br/>\r\nAabaad rahe tu…<br/>\r\nAabaad rahe tu…<br/>\r\n<br/>\r\nAe watan… mere watan<br/>\r\nAabaad rahe tu!<br/>', '2019-03-27'),
(46, 'NAZAR NA LAG', ' Sachin Jigar, Ash King', 4, 'Stree', 'audio/nazar_na_lag_jaaye.mp3', 'https://www.youtube.com/watch?v=-JMtKCqnkm0', 'trending', 'images/nazar_na_lag_jaye.jpg', 'Goriye tu kinni gori hai<br/>\r\nTu zameen pe chand ki chudi hai<br/>\r\n<br/>\r\nBuri ye badi buri hai<br/>\r\nDuniya ki neeyat chhoriye<br/>\r\n<br/>\r\nNazar na lag jaaye jaanu<br/>\r\nThought ye ghabraaye saanu<br/>\r\nNazar na lag jaaye jaanu<br/>\r\nThought ye ghabraaye saanu<br/>\r\n<br/>\r\nO..<br/>\r\nMaathe pe gore, kaala teeka bana le mujhko<br/>\r\nTujhko balaaon se bacha loon<br/>\r\nHai dhoop yeh zamaana<br/>\r\nOas ki boond hai tu<br/>\r\nPalkon ki chaaon mein chupa loon<br/>\r\n<br/>\r\nO.. goriye ye meri theory hai<br/>\r\nKi ye teri meri lead mein story hai<br/>\r\nSorry ye khud sorry hai<br/>\r\nHai jo beech apne doori ye<br/>\r\n<br/>\r\nNazar na lag jaaye jaanu<br/>\r\nThought ye ghabraaye saanu<br/>\r\nNazar na lag jaaye jaanu<br/>\r\nThought ye ghabraaye saanu<br/>', '2019-03-29'),
(48, 'KAUN TUJE', ' Palak Muchhal', 4, 'MS DHONI', 'audio/Kaun Tujhe.mp3', 'https://www.youtube.com/watch?v=atVof3pjT-I', 'most_popular', 'images/kaun_tujhe.jpg', 'Tu aata hai seene mein<br/>\r\nJab jab saansein bharti hoon<br/>\r\nTere dil ki galiyon se<br/>\r\nMain har roz guzarti hoon<br/>\r\n<br/>\r\nHawaa ke jaise chalta hai tu<br/>\r\nMain ret jaisi udti hoon<br/>\r\nKaun tujhe yun pyar karega<br/>\r\nJaise main karti hoon<br/>\r\n<br/>\r\nHo ho...<br/>\r\n<br/>\r\nMeri nazar ka safar<br/>\r\nTujhpe hi aake ruke<br/>\r\nKehne ko baaqi hai kya<br/>\r\nKehna tha jo keh chuke<br/>\r\n<br/>\r\nMeri nigaahein hain<br/>\r\nTeri nigahon pe<br/>\r\nTujhe khabar kya be-khabar<br/>\r\nMain tujhse hi chhup chhup kar<br/>\r\nTeri aankhen padhti hoon<br/>\r\nKaun tujhe yun pyaar karega<br/>\r\nJaise main karti hoon<br/>\r\n<br/>\r\nHo ho...<br/>\r\n\r\nTu jo mujhe aa mila<br/>\r\nSapne hue sirphire<br/>\r\nHathon mein aate nahi<br/>\r\nUdte hain lamhe mere<br/>\r\n<br/>\r\nMeri hansi tujhse<br/>\r\nMeri khushi tujhse<br/>\r\nTujhe khabar kya be-qadar<br/>\r\n<br/>\r\nJis din tujhko na dekhun<br/>\r\nPagal pagal phirti hoon<br/>\r\nKaun tujhe yun pyaar karega<br/>\r\nJaise main karti hoon<br/>\r\n<br/>\r\nHo ho...<br/>', '2019-03-29'),
(49, 'SAB TERA', 'Shraddha Kapoor, Armaan Malik', 4, 'BAGHI', 'audio/Sab Tera.mp3', 'https://www.youtube.com/watch?v=WRQHV3kDcyo', 'most_popular', 'images/sab_tera.jpg', 'Na jiya zindagi ek pal bhi<br/>\r\nTujhse hoke judaa sun zara<br/>\r\nBin tere mujhse naaraaz tha dil<br/>\r\nTu mila hai toh hai keh raha<br/>\r\n<br/>\r\nMain toh tere rang mein<br/>\r\nRang chuka hoon<br/>\r\nBas tera ban chuka hoon<br/>\r\nMera mujhme kuch nahi sab tera<br/>\r\n<br/>\r\nMain toh tere dhang mein<br/>\r\nDhal chuki hoon<br/>\r\nBas teri ban chuki hoon<br/>\r\nMera mujhme kuch nahi<br/>\r\nSab tera, sab tera..<br/>\r\nSab tera, sab tera..<br/>\r\n<br/>\r\nPhir dil ke raaston pe<br/>\r\nTeri aahat jo hui<br/>\r\nHar dhadkan jashan mein hai<br/>\r\nYeh inaayat jo hui (x2)<br/>\r\n<br/>\r\nMain toh tujhe milke jee uthi hoon<br/>\r\nTeri dhadkan mein chhupi hoon<br/>\r\nMera mujhme kuch nahin<br/>\r\nSab tera, sab tera..<br/>\r\nSab tera, sab tera..<br/>\r\n<br/>\r\nHey… ha…<br/>\r\n<br/>\r\nJis pal tu saath mere<br/>\r\nUss pal mein zindagi hai<br/>\r\nTujhe paake paaya sab kuch<br/>\r\nKoi khwahish ab nahi hai (x2)<br/>\r\n<br/>\r\nMmm.. main toh bas tujhse hi bana hoon<br/>\r\nTere bin main bewajah hoon<br/>\r\nMera mujhe kuch bhi nahi<br/>\r\nSab tera, sab tera..<br/>\r\nSab tera, sab tera..<br/>', '2019-03-29'),
(52, 'Aayi hai diwali ', 'Kumar Sanu, Udit Narayan', 2, NULL, 'audio/Aayi hai diwali suno ji gharwali.mp3', 'https://www.youtube.com/watch?v=0WtRNGubWGA', 'festival', 'images/download (1).jfif', 'Aayi Hai Diwali Suno Ji Gharwaali<br>\r\nAayi Hai Diwali Suno Ji Gharwaali<br>\r\nTere Kangane Ne Dil Dhadkaya Hai<br>\r\nLage Sajna Mera Aa Ra Ra Ra Ra<br>\r\nLage Sajna Mera Aa Ra Ra Ra Ra<br>\r\nLage Sajna Mera Aaj Paglaaya Hai<br>\r\nLage Sajna Mera Aaj Paglaaya Hai<br>\r\nAayi Hai Diwali Suno Ji Gharwaali<br>\r\nTere Kangane Ne Dil Dhadkaya Hai<br>\r\nAa Ra Ra Ra Ra Ra Sajna Paglaaya Hai<br>\r\nAa Ra Ra Ra Ra Ra Sajna Paglaaya Hai<br>\r\nTera Singaar Laga Bahar Aaya Re<br>\r\nAaya Tujhpe Hum Ko Pyaar<br>\r\nMardo Ka Kya Bedardo Ka Kya<br>\r\nKya Jaano Tum Kya Hota Hai Pyaar<br>\r\nKyon Bhala Hum Kare Tum Pe Aitbaar<br>\r\nBhole Hoton Ki Laali Dole Kaano Ki Baali<br>\r\nTeri Chunri Ne Jalwa Dikhaya Hai<br>\r\nLage Sajna Mera Aa Ra Ra Ra Ra<br>\r\nLage Sajna Mera Aa Ra Ra Ra Ra<br>\r\nLage Sajna Mera Aaj Paglaaya Hai<br>\r\nLage Sajna Mera Aaj Paglaaya Hai<br>\r\nCharo Taraf Diye Jal Rahe<br>\r\nDehko Ji Dekho Yeh Kya Keh Rahe<br>\r\nKahin Pe Nigahein Kahin Pe Nishana<br>\r\nHum Jaante Hai Yeh Kissa Purana<br>\r\nNa Karo Dillagi Chhodo Sataana<br>\r\nTu Yeh Maane Na Maane Hum Hai Tere Dewaane<br>\r\nDekho Mausam Mohabbat Ka Aaya Hai<br>\r\nLage Sajna Mera Aa Ra Ra Ra Ra<br>\r\nLage Sajna Mera Aa Ra Ra Ra Ra<br>\r\nLage Sajna Mera Aaj Paglaaya Hai<br>\r\nLage Sajna Mera Aaj Paglaaya Hai<br>\r\nYaaro Meri Maano Miya Biwi Ke Rishte Ko Jaano<br>\r\nPyaaro Oh Mere Pyaaro Kya Hai Jeevan Tum Yeh Pehchano<br>\r\nChhodo Chhodo Chhodo Takraar Karlo Karlo Karlo Pyaar<br>\r\nOh Chayi Nakhrewali Gharwaali Hai Gharwaali<br>\r\nOh Chayi Nakhrewali Gharwaali Hai Gharwaali<br>\r\nSara Sansaar Is Mein Samaya Hai<br>\r\nLage Sajna Mera Aa Ra Ra Ra Ra<br>\r\nLage Sajna Mera Aa Ra Ra Ra Ra<br>\r\nLage Sajna Mera Aaj Paglaaya Hai<br>\r\nLage Sajna Mera Aaj Paglaaya Hai<br>\r\nAayi Hai Diwali Suno Ji Gharwaali<br>\r\nTere Kangane Ne Dil Dhadkaya Hai<br>\r\nAa<br>\r\n\r\n\r\n', '2019-03-29'),
(53, 'Balam_Pichkari', 'Vishal Dadlani, Shalmali Kholgade', 2, NULL, 'audio/Balam_Pichkari_Full_Song_Video_Yeh_Jawaani_Hai_Deewani__Ranbir_Kapoor_Deep.mp3', 'https://www.youtube.com/watch?v=0WtRNGubWGA', 'festival', 'images/download (2).jpg', 'Balam Pichkari Jo Tune Mujhe Maari<br>\r\nToh Bole Re Zamana Kharabi Ho Gayi<br>\r\nMere Ang Raja, Jo Tera Rang Laga<br>\r\nToh Seedhi-Saadi Chhori Sharabi Ho Gayi<br>\r\nItna Maza, Kyun Aa Raha Hai<br>\r\nTune Hawa Mein Bhaang Milaya<br>\r\nItna Maza, Kyun Aa Raha Hai<br>\r\nTune Hawa Mein Bhaang Milaya<br>\r\nDugna Nasha, Kyun Ho Raha Hai<br>\r\nAankhon Se Meetha Tune Khilaya<br>\r\nHo Teri Malmal Ki Kurti Gulabi Ho Gayi<br>\r\nManchali Chaal Kaise Nawaabi Ho Gayi, Toh?<br>\r\nBalam Pichkari Jo Tune Mujhe Maari<br>\r\nToh Seedhi Saadi Chhori Sharaabi Ho Gayi<br>\r\nHaa Jeans Pahen Ke Jo Tune Maara Thumka<br>\r\nToh Lattoo Padosan Ki Bhabhi Ho Gayi (X2)<br>\r\nTeri Kalaai Hai, Haathon Mein Aayi Hai<br>\r\nMaine Maroda Toh Lagti Malaai Hai<br>\r\nMehenga Padega Ye Chaska Malaai Ka<br>\r\nUpvaas Karne Mein Teri Bhalaai Hai<br>\r\nHo Bindiya Teri Mehtaabi Ho Gayi<br>\r\nDil Ke Armaanon Mein Behisaabi Ho Gayi<br>\r\nBalam Pichkari Jo Tune Mujhe Maari<br>\r\nToh Seedhi Saadi Chhori Sharaabi Ho Gayi<br>\r\nHaa Jeans Pahen Ke Jo Tune Maara Thumka<br>\r\nToh Lattoo Padosan Ki Bhabhi Ho Gayi (X2)<br>\r\nKyun ''No-Vacancy'' Ki, Hothon Pe Gaali Hai<br>\r\nJabki Tere Dil Ka Kamra Toh Khaali Hai<br>\r\n(Kamra Toh Khaali Hai...)<br>\r\nMujhko Pata Hai Re<br>\r\nKya Chahata Hai Tu<br>\r\nBoli Bhajan Teri<br>\r\nNeeyat Qawwali Hai<br>\r\nZulmi Ye Haazir-Jawaabi Ho Gayi<br>\r\nTu Toh Har Taale Ki Aaj Chaabi Ho Gayi, Toh?<br>\r\nBalam Pichkari Jo Tune Mujhe Maari<br>\r\nToh Seedhi Saadi Chhori Sharaabi Ho Gayi<br>\r\nHaa, Jeans Pahen Ke Jo Tune Maara Thumka<br>\r\nToh Lattoo Padosan Ki Bhabhi Ho Gayi (X2)<br>\r\nHaan, Bole Re Zamana Kharabi Ho Gayi<br>\r\nHaan, Bole Re Zamana Kharabi Ho Gayi...<br>', '2019-03-29'),
(54, 'Bhaiya Mere Rakhi Ke', ' Balraj Sahani ', 2, NULL, 'audio/Bhaiya Mere Rakhi Ke - Balraj Sahani & Nanda - Chhoti Behan - Raksha Bandhan Spe.mp3', 'https://www.youtube.com/watch?v=PyAp6CAOu5U&vl=en', 'festival', 'images/download (3).jfif', 'bhaiya mere, raakhi ke bandhan ko nibhaana <br>\r\n\r\nbhaiya mere, chhoti bahan ko na bhulaana <br>\r\nDear brother, don''t forget your little sister.<br>\r\n\r\ndekho ye naata nibhaanaa, nibhaana <br>\r\nDon''t forget to fulfill the responsiblilites of a brother''s relationship.<br>\r\n\r\nbhaiya mere... <br>\r\n\r\nye din ye tyohaar khushi kaa, paavan jaise neer nadi ka <br>\r\nThis festive day of Rakhi spreads happiness, pure like the water of the river(ganges).<br>\r\n\r\nbhaayi ke ujale maathe pe, bahan lagaae mangal tika<br>\r\nOn the bright forehead of the brother, sister put a auspisousl Tikaa(red elongated tilak).<br>\r\n\r\n\r\njhuume ye saavan suhaanaa, suhaana <br>\r\nThe beautiful monsoon winds are dancing on this day as well.<br>\r\n\r\nbhaiya mere... <br>\r\n\r\nbaandh ke hamane resham dori, tum se vo ummid hai jodi <br>\r\nBy tying this silken thread on your arm, I have put all my hopes on you.<br>\r\n\r\nnaazuk hai jo daant ke jaise, par jivan bhar jaae na todi <br>\r\nIt is delicate thread but the relationship is strong to last a life time.<br>\r\n\r\njaane ye saara zamaanaa, zamaana <br>\r\nThe whole world knows this.<br>\r\n\r\nbhaiya mere... <br>\r\n\r\nshaayad vo saavan bhi aae, jo bahana ka rang na laae <br>\r\nThat time may come as well, when your sister may not be around.<br>\r\n\r\nbahan paraae desh basi ho, agar vo tum tak pahunch na paae<br> \r\nYour sister may be living far away and not able to come to you on this day.<br>\r\n\r\nyaad ka deepak jalaanaa, jalaana <br>\r\nAlways remember her.<br>\r\n\r\nbhaiya mere...<br> ', '2019-03-29'),
(55, 'Deep Diwali', ' Kishore Kumar,Dharmendra,', 2, NULL, 'audio/Deep Diwali Ke Jhuthe - Kishore Kumar,  Dharmendra, Jugnu Kids Song.mp3', 'https://www.youtube.com/watch?v=eEWPN3BuA1w', 'festival', 'images/download (4).jfif', 'Rim papapa rim pa apapa<br>\r\nRim pa apapa rim pa apapa<br>\r\nRim pa apapa o rum papapapa<br>\r\nO rum papapapa o rum papapapa<br>\r\nO rum papapapa o rum papapapa<br>\r\nO rum papapapa<br>\r\nChhote chhote nannhe<br>\r\nMunne pyaare pyaare re<br>\r\nBacche sache jag ke ujiyaare re<br>\r\nDeep deewaale ke jhoote<br>\r\nAa haa<br>\r\nRaat chalen subah toote<br>\r\nChhote chhote nanhe<br>\r\nMunne pyaare pyaare re<br>\r\nBacche sache jag ke ujiyaare re<br>\r\nDeep deewaali ke jhoote<br>\r\nAa haa<br>\r\nRaat chalen subah toote<br>\r\nInke aage rang phheeke<br>\r\nSab nazar aate hain<br>\r\nChaand taare aa haa<br>\r\nInse hi saare aa haa<br>\r\nRaushni paate hain<br>\r\nInko dekhen<br>\r\nDekh ke jhoomen<br>\r\nBaag ki daali daali<br>\r\nPhool bahaaron ke<br>\r\nJhhoothe aa haa<br>\r\nAaj khilen aur kal toote<br>\r\nChhote chhote nanhe<br>\r\nMunne pyaare pyaare re<br>\r\nBacche sache jag ke ujiyaare re<br>\r\nDeep deewaali ke jhoothe<br>\r\nArre waah re pandu<br>\r\nSaath chalen subah chhote<br>\r\nAkkad bakkad bombay soo<br>\r\nBilli number poore sau<br>\r\nSau mein lagaa dhaagaa<br>\r\nChor nikalkar bhaagaa<br>\r\nChidiyaa ghame raani raani bole<br>\r\nYe hansen to<br>\r\nHans paden sab<br>\r\nRoyen to sab royen<br>\r\nInki khaatir ham aap jaagen<br>\r\nChain se ye soyen<br>\r\nAadmi ki zindagi ka<br>\r\nYe hai sachchaa sahaaraa<br>\r\nAur sahaare sab jhoothhe<br>\r\nAa haa aaj milen aur kal toote<br>\r\nChhote chhote nanhe<br>\r\nMunne pyaare pyaare re<br>\r\nBacche sache jag ke ujiyaare re<br>\r\nDeep deewaali ke jhoothhe<br>\r\nRaat jale subah toote<br>\r\nDeep deewaali ke jhoothhe<br>\r\nRaat jale subah toote<br>\r\nRimpapapapa rimpapapapa<br>\r\nRimpapapapa rimpapapapa<br>\r\nRimpapapapa rimpapapapa paa<br>\r\nRimpapapapa rimpapapapa<br>\r\nRimpapapapa rimpapapapa<br>\r\nRimpapapapa rimpapapapa.<br>', '2019-03-29'),
(56, 'Hori Khele Raghuveera', ' Amitabh Bachchan, Hema Malini', 2, NULL, 'audio/Hori Khele Raghuveera Full Song _ Baghban _ Amitabh Bachchan, Hema Malini.mp3', 'https://www.youtube.com/watch?v=UJts4_arPpc', 'festival', 'images/download (5).jfif', 'Holi hai...<br>\r\nHoli hai...<br>\r\nPrem ke saare mantar ratt ke<br>\r\nTeri khoj mein dar-dar bhatke<br>\r\nKhol de Radha patt ghoonghat ke<br>\r\nSa ra ra...<br>\r\nLog batayein Jamuna tatt ke<br>\r\nRoop hai tera sabse hatt ke<br>\r\nJyon dekhe woh rasta bhatke<br>\r\nSa ra ra...<br>\r\nSara ra ra ra Holi Biraj ma<br>\r\nTujhse hai Rangoli Biraj ma<br>\r\nTu meri Humjoli Biraj ma<br>\r\nTujhse hai Rangoli Biraj ma (x-2)<br>\r\nHoli hai...<br>\r\nHoli hai...<br>\r\nSham-o-Sehar bas teri batiyan<br>\r\nTere bina be-swaadi ratiyan<br>\r\nAaja re aa bhi ja yeh mann tarse<br>\r\nHoli hai...<br>\r\nPrem ke saare mantar ratt ke<br>\r\nTeri khoj mein dar-dar bhatke<br>\r\nKhol de Radha patt ghoonghat ke<br>\r\nSa ra ra...<br>\r\nLog batayein Jamuna tatt ke<br>\r\nRoop hai tera sabse hatt ke<br>\r\nJyon dekhe woh rasta bhatke<br>\r\nSa ra ra...<br>\r\nSara ra ra ra Holi Biraj ma<br>\r\nTujhse hai Rangoli Biraj ma<br>\r\nTu meri Humjoli Biraj ma<br>\r\nTujhse hai Rangoli Biraj ma (x-2)<br>\r\nHoli hai...<br>\r\nHoli hai...<br>\r\nHai gumshuda mere ye palchhin<br>\r\nSapne tere aate hain raat din<br>\r\nAaja re aa bhi jaa yeh mann tarse<br>\r\nHoli hai...<br>\r\nPrem ke saare mantar ratt ke<br>\r\nTeri khoj mein dar-dar bhatke<br>\r\nKhol de Radha patt ghoonghat ke<br>\r\nSa ra ra...<br>\r\nLog batayein Jamuna tatt ke<br>\r\nRoop hai tera sabse hatt ke<br>\r\nJyon dekhe woh rasta bhatke<br>\r\nSa ra ra...<br>\r\nSara ra ra ra Holi Biraj ma<br>\r\nTujh se hai Rangoli Biraj ma<br>\r\nTu meri Humjoli Biraj ma<br>\r\nTujh se hai Rangoli Biraj ma (x-2)<br>', '2019-03-29'),
(58, 'Kaipoche', 'Salman Khan,Aishwarya Rai', 2, NULL, 'audio/Kaipoche (Video Song) _ Hum Dil De Chuke Sanam _ Salman Khan & Aishwarya Rai.mp3', '\r\nhttps://www.youtube.com/watch?v=87FYp3YLEBM', 'festival', 'images/download (7).jfif', 'Taal Se Taal Mile More Babua Baaje Dhol Mridang<br>\r\nMann Se Mann Kaa Meinl Jo Ho Toh, Rang Se Mil Jaye Rang<br>\r\nO Hori Khele Raghuveera<br>\r\nHori Khele Raghuveera, Avadh Meinin, Hori Khele Raghuveera<br>\r\nHori Khele Raghuveera, Avadh Meinin, Hori Khele Raghuveera<br>\r\nArey Hori Khele Raghuveera, Avadh Meinin, Hori Khele Raghuveera<br>\r\nHori Khele Raghuveera, Avadh Meinin, Hori Khele Raghuveera<br>\r\nHa Hilmil Aave Log Lugayi<br>\r\nHilmil Aave Log Lugayi<br>\r\nHilmil Aave Log Lugayi<br>\r\nBhai Mahalan Mein Bhira, Avadh Mein Hori Khele Raghuveera<br>\r\nArre Hori Khele Raghuveera, Avadh Mein, Hori Khele Raghuveera, Holi Hai<br>\r\nYeah Hori Khele Raghuveera, Avadh Mein ,Hori Khele Raghuveera<br>\r\nArre Hori Khele Raghuveera, Avadh Mein, Hori Khele Raghuveera<br>\r\nTaniko Sharam Nahi Aaye Dekhey Nahi Apni Umariya<br>\r\nTaniko Sharam Nahi Aaye Dekhey Nahi Apni Umariya<br>\r\nHo 60 Baras Mein Ishk Ladaye<br>\r\n60 Baras Mein Ishk Ladaye<br>\r\nMukhade Pe Rang Lagaye, Bada Rangila Sanvariya<br>\r\nMukhade Pe Rang Lagaye, Bada Rangila Sanvariya<br>\r\nChunari Pe Dale Abhira, Avadh Mein, Hori Khere Raghuveera<br>\r\nArre Chunari Pe Dale Abhira, Avadh Mein, Hori Khere Raghuveera<br>\r\nArre Hori Khele Raghuveera, Avadh Mein, Hori Khele Raghuveera<br>\r\nHa Hilmil Aave Log Lugayi<br>\r\nBhai Mahalan Mein Bhira,<br>\r\nAvadh Mein Hori Khele Raghuveera, Holi Hai<br>\r\nArre Hori Khele Raghuveera, Avadh Mein, Hori Khele Raghuveera<br>\r\nHey Abb Ke Phag Mose Khelo Naa Hori, Ha Ha Naa Khelat Naa Khelat<br>\r\nTori Shapath Main Umariya Ki Thori, Haye Haye Haye Chacha<br>\r\nTa Ta Ta Ta Ta Ra Ta Ta Ta Ta Hay Jhun Jhun Hay Jhun Jhun<br>\r\nDekhey Hai Upar Se Jhanke Nahi Andar Sajaniya<br>\r\nDekhey Hai Upar Se Jhanke Nahi Andar Sajaniya<br>\r\nUmar Chadi Hai Dil Toh Jawaan Hai<br>\r\nUmar Chadi Hai Bhaiya, Dil Toh Jawaan Hai<br>\r\nBanhon Mein Bharke Mujhe Jara Jhanka De Painjaniya<br>\r\nBanhon Mein Bharke Mujhe Jara Jhanka De Painjaniya<br>\r\nSanchi Kahe Hai Kabira Avadh Mein Hori Khele Raghuveera<br>\r\nArey Sanchi Kahe Hai Kabira Avadh Mein Hori Khele Raghuveera<br>\r\nArre<br>\r\nHori Khere Raghu<br>\r\nO Hori Khele Raghuveera Avadh Mein Hori Khele Raghuveera<br>\r\nHori Khele Raghuveera Avadh Mein Hori Khele Raghuveera<br>\r\nHori Khele Raghuveera Avadh Mein Hori Khele Raghuveera<br>\r\nHilmil Aave Log Lugayi,<br>\r\nHa Hilmil Aave Log Lugayi<br>\r\nBhai Mahalan Mein Bhira Avadh Mein Hori Khele Raghuveera, Holi Hai<br>\r\nHori Khele Raghuveera, Avadh Mein, Hori Khele Raghuveera<br>\r\nAe Bhaiyaa Hori Khele Raghuveera, Avadh Mein, Hori Khele Raghuveera<br>\r\nHori Khele Raghuveera, Avadh Mein, Hori Khele Raghuveera, Hath De Bhaiyaa<br>\r\nHori Khele Raghuveera, Avadh Mein, Hori Khele Raghuveera<br>', '2019-03-29'),
(59, 'Maiyya Yashoda ', 'Alka Yagnik,Anuradha Paudwal ', 2, NULL, 'audio/Maiyya Yashoda - Alka Yagnik Hit Songs - Anuradha Paudwal Songs.mp3', 'https://www.youtube.com/watch?v=rPvh3WsRt2Q', 'festival', 'images/download (8).jfif', 'Maiyya Yashoda<br>\r\nAnuradha Paudwal, Alka Yagnik, ...<br>\r\nmaiyya yashoda ye tera kanhaiyya<br>\r\nmother yashoda+, your kanha+<br>\r\nmaiyya yashoda ye tera kanhaiyya panghat pe meri pakde hai baiyyaan<br>\r\nhe holds my wrist at waterfront (i.e. flirts with me)<br>\r\ntang mujhe karta hai sang mere ladta<br>\r\nhe teases me, he fights with me<br>\r\nraamji ki kripa se main bachi - 2<br>\r\nsaved by but the grace of lord<br>\r\nraamji ki kripa se<br>\r\nby the grace of lord<br>\r\nmaiyya yashoda ye tera kanhaiyya panghat pe meri pakde hai baiyyaan<br>\r\ntang mujhe karta hai sang mere ladta<br>\r\nhaay<br>\r\nraamji ki kripa se main bachi<br>\r\nraamji ki kripa se main bachi<br>\r\nraamji ki kripa se<br>\r\ngokul ki galiyon mein jamuna kinaare<br>\r\nin the streets of gokul+, on the shores of jamuna<br>\r\nvo to hai kankaniya chhup chhupke maare<br>\r\nhe throws pebbles at me stealthily<br>\r\nnatkhat adayein soorat hai bholi<br>\r\nhis mischieveous styles, his innocent face<br>\r\nholi mein meri bhigaaye vo choli<br>\r\nhe wets me during holi<br>\r\nbaiyyaan na chhode<br>\r\ndoesn''t leave arm<br>\r\nkalaiyyaan marode<br>\r\ntwists the wrists<br>\r\nbaiyyaan na chhode kalaiyyaan marode<br>\r\ndoesn''t leave arm, twists the wrists<br>\r\npaiyyaan padoon phir bhi peechha na chhode<br>\r\neven when i beg, he doesn''t leave me alone<br>\r\nmeethi meethi baaton mein mujhko phasaaye<br>\r\nhe weaves me in magic of sweet nothings<br>\r\nhaay<br>\r\nsigh<br>\r\nraamji ki kripa se main bachi - 2<br>\r\nsaved by but the grace of lord<br>\r\nraamji ki kripa se<br>\r\nby the grace of lord<br>\r\njab jab bajaaye mohan muraliya<br>\r\nwhenever mohan+ plays flute<br>\r\nchhan chhan chhanakti hai meri paayaliya<br>\r\nmy anklets tinkle<br>\r\nneinon se jab vo kare chhedkhaani<br>\r\nwhen he flirts with me with his eyes<br>\r\ndil thaame reh jaaye prem deewani<br>\r\ni cannot help but hold my heart<br>\r\nsadh budh gawaayi<br>\r\ni have lost my senses<br>\r\nneendein udaayi<br>\r\nand my sleep<br>\r\nsadh budh gawaayi neendein udaayi<br>\r\ni have lost my senses and my sleep<br>\r\njo karne baithi thi vo kar na paayi<br>\r\ni couldn''t finish what i sat to do<br>\r\nbadi mushkil se dil ko sambhaala<br>\r\ni had to control my heart with great effort<br>\r\nhaay<br>\r\nsigh<br>\r\nraamji ki kripa se main bachi - 2<br>\r\nsaved by but the grace of lord<br>\r\nraamji ki kripa se<br>\r\nby the grace of lord<br>\r\ngokul ka kaanah re dil mein samaaya<br>\r\nkanha+ of gokul+ has occupied my heart<br>\r\nmain bhaagyashaali inhein maine paaya<br>\r\ni am fortunate to have found him<br>\r\nmaana ki sabke hain ye kanhaiyya<br>\r\nagreed that he is darling of all<br>\r\nkehlayenge bas tumhaare hi maiyya<br>\r\nyet he will be still your son<br><br>\r\npyaara piya hai<br>\r\ndarling is lovely<br>\r\ntumne diya hai<br>\r\nall thanks to you<br>\r\npyaara piya hai tumne diya hai<br>\r\ndarling is lovely all thanks to you<br>\r\nmamta ke aanchal mein humko liya hai<br>\r\nyou have taken us all in your loving shadows<br>\r\ncharnon mein tere o maa humko rehna hai<br>\r\nwe have to live under your blessings<br>\r\nraamji ki kripa se haan ji haan<br>\r\nby the grace of lord, yes, yes<br>\r\nraamji ki kripa se haan ji haan<br>\r\nby the grace of lord, yes, yes<br>\r\nraamji ki kripa se<br>\r\nby the grace of lord<br>\r\n\r\n', '2019-03-29'),
(60, 'Radha Kaise Na Jale', ' Aamir Khan', 2, NULL, 'audio/Radha Kaise Na Jale - Lagaan _ Aamir Khan _ Gracy Singh.mp3', 'https://www.youtube.com/watch?v=qNnvL0ztJhA', 'festival', 'images/download (9).jfif', '\r\nMadhuban mein jo Kanhaiya kisi Gopi se mile<br/>\r\nKabhi muskaaye kabhi chede kabhi baat kare<br/>\r\nRadha kaise na jale<br/>\r\nRadha kaise na jale<br/>\r\nAag tan man mein lage<br/>\r\nRadha kaise na jale<br/>\r\nRadha kaise na jale (Female)<br/>\r\n<br/>\r\nMadhuban mein bhale kanha kisi Gopi se mile<br/>\r\nMan mein toh Radha ke hi prem ke hai phool kile<br/>\r\nKisliye Radha jale (Hoyi)<br/>\r\nKisliye Radha jale (Hoyi)<br/>\r\nBina soche samjhe (Hoyi)<br/>\r\nKisliye Radha jale<br/>\r\nKisliye Radha jale (Kisliye Radha jale) (Male)<br/>\r\n<br/>\r\nO Gopiyaan taare hai<br/>\r\nChaand hai Radha<br/>\r\nPhir kyun hai usko<br/>\r\nViswaas aadha (Repeat once) (Male)<br/>\r\n<br/>\r\nKaanhaji ka jo sada<br/>\r\nIdhar udhar dhyaan rahe<br/>\r\nRadha bechaari ko phir<br/>\r\nApne pe kya maan rahe (Female)<br/>\r\n<br/>\r\nGopiyaan aani jaani hai<br/>\r\nRadha toh man ki Rani hai (Repeat once) (Male)<br/>\r\n<br/>\r\nSaanj sakha re jamna kinare<br/>\r\nRadha Radha hi kaanha pukare (Male)<br/>\r\n<br/>\r\nOhi. Ohi.<br/>\r\nBahoon ke haar jo daale koyi kanha ke gale<br/>\r\n(Radha kaise na jale<br/>\r\nRadha kaise na jale)<br/>\r\nAag tan man mein lage<br/>\r\nRadha kaise na jale<br/>\r\nRadha kaise. Na jale (Female)<br/>\r\n<br/>\r\n(Dhadin dhadin dhadin dina ho.) (repeat 3 times) (Female\r\n–)<br/>\r\n\r\nMan mein hai radhe ko<br/>\r\nKanha jo basaye<br/>\r\nToh kaanha kaahe ko<br/>\r\nUsse na bataye (Female)<br/>\r\n<br/>\r\nPrem ki apni alag<br/>\r\nBoli alag bhaasa hai<br/>\r\nBaat naino se kaho kanha ki yehi aasa hai (Male)<br/>\r\n<br/>\r\nKhana ke yeh jo naina hai<br/>\r\nChine Gopiyon ke chaina hai (Repeat once) (Female)<br/>\r\n<br/>\r\nMile nazariya huvi bawariya<br/>\r\nGori gori se koyi gujariyaa (Female)<br/>\r\n<br/>\r\nKanha ka pyaar kisi Gopiyon ke man mein jo pale<br/>\r\nKisliye Radha jale Radha jale Radha jale (Male)<br/>\r\n<br/>\r\nRadha kaise na jale (Female)<br/>\r\nKisliye Radha jale (Male)<br/>\r\nRadha kaise na jale (Female)<br/>\r\nKisliye Radha jale (Male –)<br/>\r\nKisliye Radha jale (Male –)<br/>\r\nRadha kaise na jale (Female –)<br/>\r\nKisliye Radha jale (Male –)<br/>\r\nKisliye Radha jale (Male –)<br/>\r\n<br/>\r\nAa. a. a. a.<br/>\r\nRiraraninanana…<br/>\r\nThanidada.<br/>\r\nRadha kaise na jale. Radha kaise na jale. Radha kaise na<br/>\r\njale. (Female)<br/>\r\n<br/>', '2019-03-29'),
(61, 'Udi Udi Jay ', 'Arigit Singh', 2, NULL, 'audio/Udi Udi Jay full song RAEES.mp3', 'https://www.youtube.com/watch?v=qNnvL0ztJhA', 'festival', 'images/download (10).jfif', '\r\n\r\nUdi Udi Jaye Lyrics<br/>\r\n<br/> \r\nArey udi udi udi… udi jaye..<br/>\r\n <br/>\r\nUdi udi jaye<br/>\r\nUdi udi jaye<br/>\r\nDil ki patang dekho<br/>\r\nUdi udi jaye (x2)<br/>\r\n <br/>\r\nKehne ko toh khel hai<br/>\r\nYe tera mera sanjha<br/>\r\nPar mera dil hai patang<br/>\r\nAur teri nazar manjha<br/>\r\n <br/>\r\nManjhe se lipti ye patang<br/>\r\nJudi judi jaaye<br/>\r\n <br/>\r\nUdi udi jaye<br/>\r\nUdi udi jaye<br/>\r\nDil ki patang dekho<br/>\r\nUdi udi jaye<br/>\r\n \r\nDo dil ude, do dil ude<br/>\r\nUnche aasmaano mein jude (x2)<br/>\r\n <br/>\r\n(Udi udi jaye)<br/>\r\n<br/> \r\nMujhe kab tha pata iska<br/>\r\nTere prem ka iktaara<br/>\r\nMann mein yun pal pal baajega<br/>\r\n <br/>\r\nMujhe kab thi khabar iski<br/>\r\nMere mann ke singhasan par tu<br/>\r\nSada ko yun tu birajega<br/>\r\n <br/>\r\nKoi bhi kathinayi ho ya koi ho majburi<br/>\r\nTeri meri ek bhi pal hove nahi doori<br/>\r\n <br/>\r\nManjhe se lipti ye patang<br/>\r\nJudi judi jaye<br/>\r\n <br/>\r\nUdi udi jaye<br/>\r\nUdi udi jaye<br/>\r\nDil ki patang dekho<br/>\r\nUdi udi jaye (x2)<br/>', '2019-03-29'),
(62, 'Alur-Music', 'Joe-Emrold-Owamos', 3, '--', 'audio/Gilad-Angel-Uriel-Gilad-feat-Omer-Millo.mp3', '\r\nhttps://www.youtube.com/watch?v=GDfm8pp89Uk', 'rock', 'images/rock (1).jpg', 'Africa Rising<br/>\r\nJohnny Clegg<br/>\r\nKeep this for protection<br/>\r\nDeep in your heart<br/>\r\nIt''s the Kalahari blowing<br/>\r\nUnder a southern star<br/>\r\nThere''s a new day coming<br/>\r\nI feel it in my bones<br/>\r\nAfrica Rising<br/>\r\nFrom blood on the stones<br/>\r\nI feel the wind in my sails<br/>\r\nI know I can fly<br/>\r\nI''m going to break these chains<br/>\r\nUnder a blood red sky<br/>\r\nI said Hey La<br/>\r\nI said Helele<br/>\r\nI said Hey La<br/>\r\nI said Hala<br/>\r\nIsoka lapha wena ukhatizwe<br/>\r\nGood young people<br/>\r\nBorn to bad times<br/>\r\nWhere the prophjets have failed<br/>\r\nAnd the river runs dry<br/>\r\nThere''s a new day coming<br/>\r\nAcross the divide<br/>\r\nAfrica Rising<br/>\r\nAgainst yesterday''s tide<br/>\r\nI see the young are strong<br/>\r\nAnd their dreams are proud<br/>\r\nTheir hearts are on fire<br/>\r\nWhere silence once stood<br/>\r\nI said Hey La<br/>\r\nI said Helele<br/>\r\nI said Hey La<br/>\r\nI said Hala<br/>\r\nSuka lapha wena weqath''izwe<br/>\r\n(Leave this place, you who incited the nations tofight)<br/>\r\nBaleka wena weqath''izwe<br/>\r\n(Flee, you who incited the nations tofight)<br/>\r\nSesikhatele<br/>\r\n(We are tired)<br/>\r\nAfrican moon<br/>\r\nKeep on rising<br/>\r\nShine on to the sea of Japan<br/>\r\nMillions in the darkness waiting<br/>\r\nFrom Kowloon to Amsterdam<br/>\r\nVery soon I must be leaving<br/>\r\nI hear your mother call my name<br/>\r\nPassing through the midnight hour<br/>\r\nI feel no pain<br/>\r\nI said Hey La<br/>\r\nI said Helele<br/>\r\nI said Hey La<br/>\r\nI said Hala<br/>\r\n', '2019-03-29'),
(63, 'Alur-Music', 'Traevus-Owamos', 3, NULL, 'audio/DRIZZZ-DA-SINGER-WHY-I-SAY-LOVE.mp3', 'https://www.youtube.com/watch?v=AzHi0FZMJU4', 'rock', 'images/rock (2).jpg', 'Angel Uriel<br/>\r\nGilad<br/>\r\nWasha mshuma,<br/>\r\nwasha mshuma mwingine,<br/>\r\nyeah .<br/>\r\nrains all over you,<br/>\r\nbreathe, (washa mshuma)<br/>\r\nhold on, (washa mshuma)<br/>\r\nbe strong.(washa mshuma)<br/>\r\nmoving in till you under stand just breathe<br/>\r\none breathe at a time<br/>\r\nhold on take a step at a time<br/>\r\nbe strong (washa mshuma mwingine)<br/>\r\nIt wont be long,<br/>\r\ni light a candle for a child ive never met,<br/>\r\nFlew miles for a smile i could never get,<br/>\r\nand i stand in your room<br/>\r\nand watch your sunset<br/>\r\ni question my regret.<br/>\r\nwe walk through the streets where you held your fathers hand,<br/>\r\nyour mothers home doesnt seem like a foreign land,<br/>\r\ni watch them and i question my regrets,<br/>\r\nand just remember to breathe (washa mshuma)<br/>\r\nhold on, (washa mshuma)<br/>\r\ntry to be strong, (washashuma mwingine)<br/>\r\nIt wont be long till you understand,<br/>\r\njust breathe,<br/>\r\none breathe at a time,<br/>\r\nhold on,<br/>\r\ntake a step at a time<br/>\r\nbe strong, (washa mshuma mwingine)<br/>\r\nIt wont be long till you see<br/>\r\nUriel<br/>\r\nthis mountains will celebrate you,<br/>\r\nthe miles will pay flowers on scars<br/>\r\nand light a thousand candles for the angel of sun crystal pal,<br/>\r\nooh uriel<br/>\r\nthe church bell will ring,<br/>\r\nthe rocket will fire<br/>\r\nand people will sing<br/>\r\nthey''ll tell of an angel,<br/>\r\nangel Uriel<br/>\r\nbreathe...<br/>\r\nhold on,<br/>\r\nbe strong,<br/>\r\nIt won be long,<br/>\r\ni light a candle for a child whom i ve never meet,<br/>\r\nflew miles across the world to accept defeat,<br/>\r\nand i stand here<br/>\r\nand question my regrets,<br/>\r\nyeah...<br/>\r\nyou walk through the streets,<br/>\r\nwhere you held your babies hands,<br/>\r\nstaying home where theres mum you make your stand,<br/>\r\nno questions,<br/>\r\nno regrets,<br/>\r\nbut always remember to<br/>\r\nbreathe, (washa mshuma)<br/>\r\nhold on, (washa mshuma)<br/>\r\ntry to be strong (washa mshuma mwingine)<br/>\r\nit wont be long till you understand,<br/>\r\njust breathe -one breathe at a time,<br/>\r\nhold on take a step at a time<br/>\r\nbe strong (washa mshuma mwingine)<br/>\r\nit wont be long till you see uriel,<br/>\r\nthis montains will celebrate you,<br/>\r\nthe miles will paint flowers on sky,<br/>\r\nand light a thousand candles for the angel of sun crystal pal uriel<br/>\r\nthe church bell will ring,<br/>\r\nthe rocket will fire and<br/>\r\npeople will sing<br/>\r\nthey''ll tell of an angel<br/>\r\nangel Uriel<br/>\r\n...breathe...<br/>\r\nthe church bell will ring<br/>\r\nbreathe...<br/>\r\nangel Uriel<br/>\r\nangel Uriel<br/>\r\nwasha mshuma<br/>\r\n\r\n', '2019-03-29'),
(65, 'Aah-ko-chahiye', 'singh-sings', 5, NULL, 'audio/aah-ko-chahiye-ek-umar-assar-honay-takk---jagjit-singh-sings-mirza-ghalib.mp3', 'https://www.youtube.com/watch?v=Pb-AAPtbe-Q', 'sufi', 'images/sufi (1).jfif', 'aah ko chaahie ek umr asar hone tak<br/>\r\nkaun jiitaa hai tere zulf ke sar hone tak<br/>\r\n<br/>\r\naashiqii sabr talab aur tamannaa betaab<br/>\r\ndil kaa kyaa ra.Ng karuu.N khuun-e-jigar hone tak<br/>\r\n<br/>\r\nham ne maanaa ke taGakul na karoge lekin<br/>\r\nkhaak ho jaae.nge ham tum ko khabar hone tak<br/>\r\n<br/>\r\nGam-e-hastii kaa ''asad'' kisase ho kuz-marg-e-ilaaj<br/>\r\nshamaa har ra.Ng me.n jalatii hai sahar hone tak<br/>', '2019-03-29'),
(66, 'Bazeecha', 'jagjit-singh', 5, NULL, 'audio/bazeecha-e-atfaal-hai-duniya-mere-agay--jagjit-singh-sings-mirza-ghalib', 'https://www.youtube.com/watch?v=iyejL8wwrGY', 'sufi', 'images/sufi (2).jfif', 'bas ke dushwaar hai har kaam kaa aasaa.n honaa<br/>\r\naadamii ko bhii mayassar nahii.n insaa.n honaa<br/>\r\n<br/>\r\ngiriyaa chaahe hai Karaabii mere kaashaane kii<br/>\r\ndar-o-diiwaar se Tapake hai biyaabaa.n honaa<br/>\r\n<br/>\r\n\r\n\r\nwaa-e-diiwaanagii-e-shauq ke har dam mujhako<br/>\r\naap jaanaa udhar aur aap hii hairaa.N honaa<br/>\r\n<br/>\r\nhaif us chaar girah kapa.De kii qisamat Gaalib<br/>\r\njisakii qisamat me.n hai aashiq kaa garebaa.N honaa<br/>\r\n', '2019-03-29');
INSERT INTO `music` (`id`, `name`, `artist`, `category_id`, `album`, `audio_path`, `video_url`, `type`, `image_path`, `lyrics`, `date_added`) VALUES
(67, 'Bildady', 'Khaligraph Jones', 6, NULL, 'audio/Bildady-I-FOUND-LOVE.mp3', '\r\nhttps://www.youtube.com/watch?v=lhLKMC4tMrw', 'hiphop', 'images/hiphop (1).jpg', 'Ay Motif turn me up on the headphones bruh<br>\r\nYCee what''s happening?<br>\r\nY''all already know what it is, man, outchea<br>\r\nTryna get this gwala baby, hahahaah<br>\r\nSupermodel on the floor (wooh!)<br>\r\nShe be working on the pole (Eyy!)<br>\r\nShe be working for the dough (Damn!)<br>\r\nAnd she be working for some more (Hahahaa!)<br>\r\nMe, I be popping my collar (Iyeeea!!)<br>\r\nYou got business, you should holla (Jones!)<br>\r\nYou ain''t messing with the gwala (Gyeah!)<br>\r\nYou ain''t messing with the gwala (Raaah!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Iyeeea!!!)<br>\r\nYou ain''t messing with the gwala (Eyy!!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Le gwala!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Iyeeea!!!)<br>\r\nI be getting groupie lovin'' (wooh!)<br>\r\nBlack girls & them white chicks<br>\r\nThey be lovin'' how I cut it (Jones!)<br>\r\nCause they ain''t seen no nigga like this<br>\r\nRubber band on the wrist (wrist)<br>\r\nThat means I be countin'' the gwala (gwala!)<br>\r\n100 grand on the bitch (bitch)<br>\r\nI know she be yearnin'' to holla (Iyeeeah!!!)<br>\r\nA1''s on ''em feet, hoe<br>\r\nBlack jeans with the Balmain<br>\r\nNever slang crack in the streets tho''<br>\r\nBut I pack heat like a (?)<br>\r\nDope lines, me I got those<br>\r\nSo these rappers couldn''t take it far<br>\r\nStreet niggas call me Pablo<br>\r\nCause they know I got them escobars<br>\r\nSide chick got a big ass<br>\r\nBut I gotta say, she a little dumb<br>\r\nI supply dick then I dip fast<br>\r\nCause my main chick always get it done<br>\r\nI don''t know how I get ''em (Get ''em!)<br>\r\nAll I know is I hit ''em (Hit ''em!)<br>\r\nMy whole life''s like a riddle (Riddle!)<br>\r\nThey always want me in the middle<br>\r\nKakiitika mi'' nita(?) (wooh!)<br>\r\nNa kakipita mi'' na lugha (uungh!)<br>\r\nNa kakijipa mi'' nitamgusa (aaii!)<br>\r\nNa kakishika itauma (Iyeeeah!!!)<br>\r\nSupermodel on the floor (wooh!)<br>\r\nShe be working on the pole (Eyy!)<br>\r\nShe be working for the dough (Damn!)<br>\r\nAnd she be working for some more (Hahahaa!)<br>\r\nMe, I be popping my collar (Iyeeea!!!)<br>\r\nYou got business, you should holla (Jones!)<br>\r\nYou ain''t messing with the gwala (Gyeah!)<br>\r\nYou ain''t messing with the gwala (Raaah!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Iyeeea!!!)<br>\r\nYou ain''t messing with the gwala (Eyy!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Le gwala!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Iyeeea!!!)<br>\r\nThese bitches is all in my phone (phone)<br>\r\nThey cannot leave me alone (''lone)<br>\r\nThey wanna f with the Jones<br>\r\nThese bitches is dyin'' to bone<br>\r\nSo I just hit it till 6 in the morn''<br>\r\nCause of the booze that I''m on<br>\r\nI tap in it then I''ll be gone<br>\r\nI''m totally up in my zone<br>\r\nUh, club stay lit when I roll up, everybody wanna get turnt (yeah!)<br>\r\nIf the hoop''s on fire, we don''t care,<br>\r\nmy nigga, let them mother f burn (yeah!)<br>\r\nDoesn''t get any better than this, so y''all take notes & learn (yeah!)<br>\r\nAnd if it ain''t cash, no offence, but we ain''t really not concerned<br>\r\nFor real, I''m really not concerned<br>\r\nEverybody really not gon'' earn<br>\r\nCheck out my super ex-girlfriend<br>\r\nKill Bills like Uma Thurman<br>\r\nI ain''t gon'' wait on my turn<br>\r\nRight now you boys gon'' learn<br>\r\nI swear you boys gon'' learn<br>\r\nHahahahaaaaah<br>\r\nYeah, hold up, I''m Young carter<br>\r\nI''m only here for the gwala<br>\r\nGwala that rhymes with the dollar<br>\r\nYou got business, you should holla<br>\r\nI want the money & long stacks<br>\r\nFree business, what do you call that?<br>\r\nMy dad will be pissed if he heard that<br>\r\nSo I am not fucking with all that<br>\r\nGot cheese on my son, said I fuck with the<br>\r\nAnd said money way longer than dreads on a rasta<br>\r\nGet to a point where I''m thuggin'' in cash<br>\r\nY''all gonna pay me in Grammys & Oscars<br>\r\nBread on my mind<br>\r\nGoal on my conscious<br>\r\nYo chic visit you but she live in my boxers<br>\r\nGetting so big everywhere that I go<br>\r\nI''m gonna need me an army of bouncers<br>\r\nLately, I''ve been feeling like Pablo<br>\r\nMoney, power like narcos<br>\r\nSee the money with my eyes closed<br>\r\nChop the money like some nachos<br>\r\nOh God, no be lie<br>\r\nSwear down me no lie<br>\r\nGot the whole club jumpin''<br>\r\nWe turnin'' up like Maasai<br>\r\nTurning up like we crazy<br>\r\nNiggas know that we wavy<br>\r\nNiggas can''t afford to pay me<br>\r\nWay, way, way wavy<br>\r\nWait a minute, let me learn<br>\r\nKhaligraph you the man<br>\r\nAnd you know Jagaban<br>\r\nAin''t nobody badder than<br>\r\nSupermodel on the floor (wooh!)<br>\r\nShe be working on the pole (Eyy!)<br>\r\nShe be working for the dough (Damn!)<br>\r\nAnd she be working for some more (Hahahaa!)<br>\r\nMe, I be popping my collar (Iyeeea!!)<br>\r\nYou got business, you should holla (Jones!)<br>\r\nYou ain''t messing with the gwala (Gyeah!)<br>\r\nYou ain''t messing with the gwala (Raaah!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Iyeeea!!!)<br>\r\nYou ain''t messing with the gwala (Eyy!!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Le gwala!)<br>\r\nYou ain''t messing with the gwala (Gwala!)<br>\r\nYou ain''t messing with the gwala (Iyeeea!!!)<br>\r\nHeheheheheee<br>\r\nGhana<br>\r\nLink up daddy<br>\r\nYo, shout out Khaligraph Jones one time & shout out the whole 254<br>\r\nWe pop the shillings, the dollars, the pounds, the rand, the naira<br>\r\nThe fucking gwala baby!!!<br>\r\nHahahahah<br>', '2019-03-29'),
(68, 'Darassa', 'Dizasta Vina', 6, NULL, 'audio/Darassa-Weka-Ngoma.mp3', 'https://www.youtube.com/watch?v=ixNiYxDBUjE', 'hiphop', 'images/hiphop (2).jpg', 'ah!<br>\r\nnilipaa sasa natua<br>\r\nkwenye/kwenye<br>\r\nsiri ya moyo<br>\r\nna siri ya moyo<br>\r\nanayeijua mwenye/<br>\r\nmwenye ujasiri wa<br>\r\nkutunza nafanya<br>\r\nninachodhani ni<br>\r\nsahihi kitachotokea<br>\r\nnitajua mbele.<br>\r\n\r\nwanasema mwanaharamu<br>\r\nhaijui laana/ kashalaanika<br>\r\nnasikitika kuwa haujui<br>\r\nkama/ naonekana ka''<br>\r\nkondoo kwa mchungaji<br>\r\nlakini...lakini kwa ndani<br>\r\nmi'' ni chui mama.<br>\r\n\r\nkwa mfano nakuita mpenzi/<br>\r\nna tabasamu zuri wakati<br>\r\nnajua kuwa sikupendi/<br>\r\nkuitoa hii siri ndo'' siwezi/<br>\r\nkwahiyo nitakudanganya<br>\r\nmpaka ifike siku niutimize<br> \r\nushenzi.<br>\r\n\r\nhuwa nawaza nikuweke<br>\r\nufahamu/ mtambue<br>\r\nkuwa mpo wengi<br>\r\nna lengo niwateke<br>\r\nkwa zamu/ niwaumize<br>\r\nili mpeleke salamu/<br>\r\nmasikini mrembo<br>\r\nnashangaa jinsi unavo''ngoja<br>\r\npete kwa hamu.<br>\r\n\r\nvile hunioni kwenye<br>\r\nmakundi ya baa/<br>\r\nna bahati nzuri haujawahi<br>\r\nkusikia nikizushiwa uzushi<br>\r\nkitaa/ nakununulia<br>\r\nrubi kadhaa/ unahisi nakujali<br>\r\nkumbe unampigia mbuzi gitaa.<br>\r\n\r\nsometimes unanisongea nguna/<br>\r\nau wali ukidhani mi'' najali ilihali<br>\r\nsina habari, sina hisia siwazi <br>\r\nhata kukuonea huruma/<br>\r\nna sibadili dhambi hata<br>\r\nmbingu ikisogea nyuma<br>\r\n\r\nah!<br>\r\nnashiriki nawe nyakati<br>\r\ntwitter mpaka instagram/<br>\r\npicha unani-hashtag drunk in love/<br>\r\nnanunua brand za gharama za<br>\r\nhand bag/ perfume kali<br>\r\nsimu ya ghali breakfast<br>\r\nzanzibar/<br>\r\n\r\nhaimaanishi kuwa<br>\r\ntunaianza safari/<br>\r\nnataka nikuandalie maumivu<br>\r\nmakali/ nahitaji nikuguse<br>\r\nili kila unachokiona<br>\r\nkiwe kinafanya unikumbuke<br>\r\nni hatari.<br>\r\n\r\ninaitwa zuia nanga kabla<br>\r\nbado haijang''oa/<br>\r\nmaana haujaheshimu <br>\r\nmvua kama bado hujaloa/<br>\r\nkwa huu mchango ninaotoa/<br>\r\nndo'' unafanya unazama<br>\r\nzaidi kiasi unaiwaza mipango<br>\r\nya ndoa.<br>\r\n\r\njicho la tatu hauna<br>\r\nfungua jicho lako la pili/<br>\r\nutagundua kila ninachofanya<br>\r\nkwako batili/ unanipenda mno<br>\r\nndo'' maana haujaona bado<br>\r\ndalili/ kuwa we sio wa kwanza<br>\r\nwala haupo kwenye<br>\r\nmpango wa pili.<br>\r\nah!!<br>\r\n\r\nunaniletea zawadi toka<br>\r\nmajuu/ kuna wenzio<br>\r\nnilishawaacha<br>\r\nna walinichora tattoo/<br>\r\nmi sio tunda mama...<br>\r\nmama mi'' kidonda<br>\r\nutachelewa kusonga<br>\r\nka'' bado unaingoja nafuu.<br>\r\n\r\nsherehe ya birthday yako<br>\r\nkwenye ''temple'' ya anasa/<br>\r\numekuwa ''mental'' kwa<br>\r\nhuu mwendo ndo''<br>\r\numenasa/<br>\r\nkiasi unahisi huu ni upendo<br>\r\nna sasa/ hautambui kuwa<br>\r\ntukishiriki tendo tu nakuacha.<br>\r\n\r\nkichwa changu hichi,kichwa <br>\r\nchangu kishajadili/ kwamba<br>\r\nnitalala na wewe na<br>\r\nwewe na haifiki jumapili/ <br>\r\nnitakuwa nimeshakuacha <br>\r\nah! utanitafuta<br>\r\nkwenye simu ambayo<br>\r\nnamba nitakuwa nishaibadili.<br>\r\n\r\nutanitafuta mara mbili/<br>\r\nmara tatu kisha nne<br>\r\nutagundua kurudi<br>\r\nsina dalili/ ngoja ngoja<br>\r\nitang''ata moyo wako<br>\r\nkikatili/ mja wa<br>\r\nwatu maumivu<br>\r\nhukujiandaa kuyakabili.<br>\r\n\r\nutanipamba majina ya<br>\r\nkikafili/ sitasikia maana<br>\r\nnitakuwa mbali nishasafiri/<br>\r\nnishasahau utatunga nahau<br>\r\nkukanda mwili/ na huo<br>\r\nwakati haukuwahi kuutabiri/<br>\r\nila upo.<br>\r\n\r\nutaumia utashindwa kusimulia/<br>\r\nutaniulizia kwa wanaonijua<br>\r\nwatakwambia/ kwamba<br>\r\nhauna tena chako<br>\r\nokota vipande vya moyo wako<br>\r\nnenda zako kaandike<br>\r\ntanzia.<br>\r\n\r\nkisha watajua wenzio/<br>\r\nwanafiki watacheka, <br>\r\nwanaokujali wataangua kilio/<br>\r\nwatakusindikiza kulia/<br>\r\nwatakupa pole wengine watasema<br>\r\ntulikuambia/ kuwa<br>\r\nwanaume wote mbwa!!<br>\r\n\r\ntaswira itazongwa<br>\r\nna wingu/<br>\r\npicha utazichoma<br>\r\nkwa kisu/<br>\r\nutanitukana mara mwana<br>\r\nharamu mara malaya/<br>\r\nrafiki zako wakuu watakuwa<br>\r\nfilamu na riwaya.<br>\r\n\r\nwimbo niliokuimbia<br>\r\nkamwe hautokukonga/<br>\r\nutachoma mkuki moyoni<br>\r\nkisha kunyonga/<br>\r\nutaendelea kungoja/<br>\r\nutagundua mvumilivu<br>\r\nhali mbivu hiyo<br>\r\nmethali iliongopa/<br>\r\nutagundua ilikuwa<br>\r\nni soga/<br>\r\n\r\nhii itafanya ukonde<br>\r\nna kuanza/<br>\r\nkutumia pombe na ganja/<br>\r\nnayajua haya yote<br>\r\nkwa maana ndo nilikotoka/<br>\r\nutasimama kijasiri<br>\r\nna mwisho utadondoka/<br>\r\n''sikiliza''<br>\r\n\r\nwataleta daktari <br>\r\nakuulize nini shida/<br>\r\nhawatapata<br>\r\njawabu kabisa/<br>\r\nwataleta sheikh,<br>\r\nwataleta mchungaji <br>\r\nwa kanisa/<br>\r\nwatasahau kwamba<br>\r\nmoyo uliovunjika<br>\r\nhauna tiba.<br>\r\n\r\nNatamani nikuambie kuwa nimekuteka makusudi/ maana unasikia na hujifunzi/ nikuumize kama mke wangu mpuuzi/ aliyekimbia na rafiki yangu siku moja baada ya harusi.<br>\r\n\r\nnilishaambiwa na<br>\r\nmama nikapuuzia/<br>\r\nkuwa haujawahi<br>\r\nkupenda kama <br>\r\nhaujawahi kulia/<br>\r\nkuna muda mtu mbaya<br>\r\nhutengwa na hatia/<br>\r\nmaana kafiri hazaliwi<br>\r\nutengenezwa na dunia.<br>\r\n\r\nukijiua sitakuona<br>\r\nmzembe amini/<br>\r\nnitakuvalisha pete<br>\r\nruksa uipeleke baharini/<br>\r\nnajua tiba ya <br>\r\nupweke amini/<br>\r\nmwisho wako ni<br>\r\nkuwa kicheche kama<br>\r\nmimi.<br>\r\n\r\nhapo utajua kunihukumu<br>\r\nsio haki/<br>\r\nmwanamke kama<br>\r\nwewe ndio amenifanya<br>\r\nniwe muasi/<br>\r\nbila hofu wala<br>\r\nkiwewe/<br>\r\nnitaendelea kuzunguka<br>\r\nkutafuta wasichana <br>\r\nVipofu kama wewe.<br>\r\n\r\nsina hatia ..<br>', '2019-03-29'),
(69, 'Abhi Ghar Na Jana', 'Pankaj Udhas', 7, NULL, 'audio/Abhi Ghar Na Jana(bossmobi).mp3', 'https://www.youtube.com/watch?v=rES8U1HczTU', 'ghazal', 'images/ghazal (1).jfif', 'Abhi Ghar Na Jana Abhi Ghar Na Jana.<br>\r\nYe Bikhri Si Zolfe<br>\r\nYe Pehla Sa Kajal<br>\r\nYe Phika Sa Gajra<br>\r\nYe Sinmta Sa Anchal<br>\r\nTere Haal Sey Log Pehchan Lenge<br>\r\nTujhe Dekh Kar Sub Mujhe Jaan Lenge…<br>\r\nMujhe Jan Lenge……<br>\r\nAbhi Ghar Na Jana Abhi Ghar Na Jana.<br>\r\nJo Poche Ga Koi Tu Tum Kia Kahogi<br>\r\nSawalo Ki Bochar Me Chup Rahogi<br>\r\nPareshan Ghabrai Si Khamushi Me<br>\r\nJawabo Ki Manzil Bohot Door Hogi<br>\r\nBozorgo Ki Ankhe Ura Degi Rangat<br>\r\nSaheli K Tane Kaha Tak Sahogi<br>\r\nNa Ban Jai Apna Milan Ek Fasana.<br>\r\nAbhi Ghar Na Jana Abhi Ghar Na Jana.<br>\r\nYe Behke Qadam Larkharati Jawani<br>\r\nHe Betab Dil Or Muhabbat Diwani<br>\r\nShafaq Jese Galo Pe Aubhri Hovi He<br>\r\nMere Hontoon Ki Ek Mehekti Nishani<br>\r\nTere Jism Se Urti Meri Ye Khusho<br>\r\nSuna Degi Har Ek Ko Sari Kahani<br>\r\nNa Banjai Khud Jaal Har Ek Bahana<br>\r\nAbhi Ghar Na Jana Abhi Ghar Na Jana.<br>\r\nKhuda Na Kare Ab Tere Bin Jiyon Me<br>\r\nYe Dunya Tu Kia He K Jannat Na Loon Me<br>\r\nTere Ashk Me Apni Ankhoo Me Bharlo<br>\r\nJo Maut Aay Tu Tere Badle Maroo Me<br>\r\nYe Jiwan Tu Kia He Jo Mil Jai Mujko<br>\r\nTu Ye Chand Suraj Bhi Sadke Karo Me<br>\r\nAgar Mar Gai Phir Janam Leke Aana….<br>\r\nAbhi Ghar Na Jana Abhi Ghar Na Jana.<br>\r\nAbhi Ghar Na Jana Abhi Ghar Na Jana.<br>', '2019-03-29'),
(70, 'BAAT KARNI MUJHE', 'Pankaj Udhas-', 7, NULL, 'audio/BAAT KARNI MUJHE(bossmobi).mp3', 'https://www.youtube.com/watch?v=uCPnSifHGjo', 'ghazal', 'images/ghazal (2).jfif', 'baat karni mujhe mushkil kabhi aisi to na thi<br>\r\njaisi ab hai teri mahfil kabhi aisi to na thi<br>\r\n\r\nle gaya chin k kaun aj tera sabr-o-qarar<br>\r\nbeqarari tujhe ai dil kabhi aisi to na thi<br>\r\nbaat karni mujhe mushkil kabhi aisi to na thi<br>\r\n\r\nun ki ankhon ne Khuda jane kiya kya jadu<br>\r\nk tabiyat meri mael kabhi aisi to na thi<br>\r\nbaat karni...<br>\r\n\r\nchashm-e-qatil meri dushman thi hamesha lekin<br>\r\njaise ab ho gai qatil kabhi aisi to na thi<br>\r\n\r\nbaat karni mujhe mushkil kabhi aisi to na thi<br>\r\njaisi ab hai teri mahfil kabhi aisi to na thi<br>', NULL),
(71, '05 Ek Bar Shri Bhole', 'Niranjan Pandya', 11, NULL, 'audio/05 Ek Bar Shri Bhole Bhandari - (Niranjan Pandya)(bossmobi).mp3', 'https://www.youtube.com/watch?v=8W9x5Pbg2r0', 'bhakti', 'images/bhakti (1).jfif', 'Ek Din Vo Bhole Bhandari<br>\r\nEk Din Vo Bhole Bhandari Bankar Braj Ki Naari Vo Gokul Me Aagaye<br>\r\nHo Gokul Me Aagaye Gokul Me Aagaye<br>\r\n\r\nEk Baar Shree Bhole Bhandari Bankar Braj Ki Naari Gokul Me Aagaye<br>\r\nHo Gokul Me Aagaye Gokul Me Aagaye<br>\r\n\r\nParvati Ne Mana Kiya Per Naa Mane Tripurari<br>\r\nGokul Me Aagaye Gokul Me Aagaye<br>\r\n\r\nEk Din Vo Bhole Bhandari<br>\r\nEk Din Vo Bhole Bhandari Bankar Braj Ki Naari Vo Gokul Me Aagaye<br>\r\nHo Gokul Me Aagaye Gokul Me Aagaye<br>\r\n\r\nEk Baar Shree Bhole Bhandari Bankar Braj Ki Naari Gokul Me Aagaye<br>\r\nHo Gokul Me Aagaye Gokul Me Aagaye<br>\r\n\r\nParvati Ne Mana Kiya Per Naa Mane Tripurari<br>\r\nGokul Me Aagaye Gokul Me Aagaye<br>\r\n\r\nParvati Se Bole Bhole O Mai Bhi Chalunga Tore Sang Me<br>\r\nParvati Se Bole Bhole Mai Bhi Chalunga Tore Sang Me<br>\r\n\r\nRadhe Sang Krishna Naache Mai Bhi Naachunga Tore Sang Me<br>\r\nRadhe Sang Krishna Naache Mai Bhi Naachunga Tore Sang Me<br>\r\n\r\nRas Rachega<br>\r\nRas Rachega Braj Me Bhari<br>\r\nHame Dikha De Pyari Gokul Me Aagaye<br>\r\nHame Dikha De Pyari Gokul Me Aagaye<br>\r\n\r\nRas Rachega<br>\r\nRas Rachega Braj Me Bhari<br>\r\nHame Dikha De Pyari Gokul Me Aagaye<br>\r\nHame Dikha De Pyari Gokul Me Aagaye<br>\r\n\r\nO Mere Bhole Swami Kaise Le Jau Tumhe Ras Me<br>\r\nMohan Ke Siva Koi Purush Naa Aave Iss Ras Me<br>\r\nHas Karegi Braj Ki Naari Maano Baat Hamari<br>\r\nGokul Me Aagaye O Gokul Me Aagaye<br>\r\nHas Karegi Braj Ki Naari Maano Baat Hamari<br>\r\nGokul Me Aagaye O Gokul Me Aagaye<br>\r\n\r\nAesa Saja De Mujhe Kanhaiya Naa Jaane Mere Raj Ko<br>\r\nMai Hu Saheli Teri Esa Batana Braj Raj Ko<br>\r\nLaga Ke Gajra Bandh Ke Saari Chal Chale Matvali<br>\r\nGokul Me Aagaye O Gokul Me Aagaye<br>\r\n\r\nAesi Bajayi Bansi<br>\r\nAesi Bajayi Bansi Sudh Budh Bhoole Bhole Naath Re Oye Hoye<br>\r\nAesi Bajayi Bansi Sudh Budh Bhoole Bhole Naath Re Oye Hoye<br>\r\nAa Hi Gaye Re Sambhu Samajh Gaye Braj Naath Re<br>\r\nSarak Gayi Jab Sir Saari<br>\r\nSarak Gayi Jab Sir Saari Puchhta Ye Banwari<br>\r\nGokul Me Aagaye O Gokul Me Aagaye<br>\r\n\r\nSarak Gayi Jab Sir Saari Puchhta Ye Banwari<br>\r\nGokul Me Aagaye O Gokul Me Aagaye<br>\r\n\r\nEk Din Vo Bhole Bhandari Bankar Braj Ki Naari Vo Gokul Me Aagaye<br>\r\nHo Gokul Me Aagaye Gokul Me Aagaye<br>', '2019-03-29'),
(72, 'Har-Krishna', 'Niranjan Pandya', 11, NULL, 'audio/Har-Krishna-Hare-Krishna-Krishna-Krishna-Hare-Hare.mp3', 'https://www.youtube.com/watch?v=bSFVo5yDAe8', 'bhakti', 'images/bhakti (2).jfif', 'Hey gopal krishna karon aarti teri<br>\r\nHey priyapati main karun arti teri<br>\r\nHey gopal krishna karon aarti teri<br>\r\nHey priyapati main karun arti teri<br>\r\nTujh pe o kanha bali bali jaaun<br>\r\nSaanj savere tere gun gaaun<br>\r\nPrem mein rangee main<br>\r\nRangee bhakti mein teri<br>\r\nHey gopal krishna karon aarti teri<br>\r\n\r\n||~~Interlude 1||<br>\r\n\r\nYe maati ka kan hain tera<br>\r\nMann aur praan bhi tere<br>\r\nMain ek gopi tum ho kanhaiya<br>\r\nTum ho bhagwan mere<br>\r\nYe maati ka kan hain tera<br>\r\nMann aur praan bhi tere<br>\r\nMain ek gopi tum ho kanhaiya<br>\r\nTum ho bhagwan mere<br>\r\nkrishna krishna krishna rate atma meri<br>\r\nHey gopal krishna karon aarti teri<br>\r\nHey priyapati main karun arti teri<br>\r\n\r\n||~~Interlude 2||<br>\r\n|Hare krishna hare krishna krishna|<br>\r\n|krishna hare hare<br>\r\n|Hare krishna hare krishna krishna<br>\r\n|krishna hare hare<br>\r\nHare rama hare rama rama rama hare hare|<br>\r\nHare rama hare rama rama rama hare hare|<br>\r\n\r\nkaanha tera roop anupam<br>\r\nMann ko harta jaayein<br>\r\nMann ye chaahein<br>\r\nHarpal ankhiya tera darshan paaye<br>\r\nkaanha tera roop anupam<br>\r\nMann ko harta jaayein<br>\r\nMann ye chaahein<br>\r\nHarpal ankhiyan tera darshan paaye<br>\r\nDarsh tera prem tera aash hain meri<br>\r\nDarsh tera prem tera aash hain meri<br>\r\nHey gopal krishna karon aarti teri.<br>\r\nTujh pe o kanha bali bali jaaun<br>\r\nSaanj savere tere gun gaaun<br>\r\nPrem mein rangee main<br>\r\nRangee bhakti mein teri<br>\r\nHey gopal krishna karon aarti teri<br>\r\nHey priyapati main karun arti teri<br>\r\nHey gopal krishna karon aarti teri<br>\r\nHey priyapati main karun arti teri<br>\r\nHey gopal krishna karon aarti teri<br>\r\nHey priyapati main karun arti teri<br>', '2019-03-29'),
(74, 'Africa-Rising', 'Anaetoh Peter', 3, 'Africa-Rising', 'audio/Gilad-Angel-Uriel-Gilad-feat-Omer-Millo.mp3', 'https://www.youtube.com/watch?v=GDfm8pp89Uk', 'rock', 'images/rock (3).jpg', 'Africa Rising<br/>\r\nJohnny Clegg<br/>\r\nKeep this for protection<br/>\r\nDeep in your heart<br/>\r\nIt''s the Kalahari blowing<br/>\r\nUnder a southern star<br/>\r\nThere''s a new day coming<br/>\r\nI feel it in my bones<br/>\r\nAfrica Rising<br/>\r\nFrom blood on the stones<br/>\r\nI feel the wind in my sails<br/>\r\nI know I can fly<br/>\r\nI''m going to break these chains<br/>\r\nUnder a blood red sky<br/>\r\nI said Hey La<br/>\r\nI said Helele<br/>\r\nI said Hey La<br/>\r\nI said Hala<br/>\r\nIsoka lapha wena ukhatizwe<br/>\r\nGood young people<br/>\r\nBorn to bad times<br/>\r\nWhere the prophjets have failed<br/>\r\nAnd the river runs dry<br/>\r\nThere''s a new day coming<br/>\r\nAcross the divide<br/>\r\nAfrica Rising<br/>\r\nAgainst yesterday''s tide<br/>\r\nI see the young are strong<br/>\r\nAnd their dreams are proud<br/>\r\nTheir hearts are on fire<br/>\r\nWhere silence once stood<br/>\r\nI said Hey La<br/>\r\nI said Helele<br/>\r\nI said Hey La<br/>\r\nI said Hala<br/>\r\nSuka lapha wena weqath''izwe<br/>\r\n(Leave this place, you who incited the nations tofight)<br/>\r\nBaleka wena weqath''izwe<br/>\r\n(Flee, you who incited the nations tofight)<br/>\r\nSesikhatele<br/>\r\n(We are tired)<br/>\r\nAfrican moon<br/>\r\nKeep on rising<br/>\r\nShine on to the sea of Japan<br/>\r\nMillions in the darkness waiting<br/>\r\nFrom Kowloon to Amsterdam<br/>\r\nVery soon I must be leaving<br/>\r\nI hear your mother call my name<br/>\r\nPassing through the midnight hour<br/>\r\nI feel no pain<br/>\r\nI said Hey La<br/>\r\nI said Helele<br/>\r\nI said Hey La<br/>\r\nI said Hala<br/>\r\n', '2019-03-31'),
(75, 'RANG RASIYA', 'Meena Patel\r\n', 12, NULL, 'audio/001 RANG RASIYA.mp3', 'https://www.youtube.com/watch?v=bSFVo5yDAe8', 'garba', 'images/garba(1).jfif', 'https://lyricstranslate.com/en/rang-rasiya-title-song-flaming-colours-passion.html\r\n\r\nInka saath hai jaisay\r\nMaati sang kumhar\r\nMaati banjave hai moorat\r\nLage iska haath\r\nChaap tilak dono ki hovay\r\nJab hovay ye saath\r\n \r\nYe bhi hai kuch aadha aadha\r\nWo bhi rahe adhori\r\nPhir bhi pheray mun kyun karay hain\r\nAisi kya majboori (x2)\r\n \r\nSooni sooni si raaten or nindiya\r\n \r\nRangrasiya rang jare\r\nRang rang de sapno mein\r\nRangrasiya, rangrasiya (x3)\r\n \r\nIshq ka khel naseebon ka hai\r\nJaane kya likha hai\r\nNaa koyi parh paya isko<br/>\r\nNaa koyi samjha hai (x2)<br/>\r\n <br/>\r\nTu hi parh le or samajh le satrangiya<br/>\r\n <br/>\r\nRangrasiya rang jare<br/>\r\nRang rang de sapno mein<br/>\r\nRangrasiya, rangrasiya (x3)<br/>\r\n <br/>\r\nDill ki dharkan sooni sooni<br/>\r\nSaanse bhi adhori<br/>\r\nAadha aadha mile to hovay<br/>\r\nKamiyaan saari puri (x2)<br/>\r\n <br/>\r\nRahay kyun rootha rootha tu manbasiya<br/>\r\n <br/>\r\nRangrasiya rang jare<br/>\r\nRang rang de sapno mein<br/>\r\nRangrasiya, rangrasiya (x3)<br/>', '2019-04-04');

-- --------------------------------------------------------

--
-- Table structure for table `playlist`
--

CREATE TABLE `playlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `playlist`
--

INSERT INTO `playlist` (`id`, `user_id`, `name`) VALUES
(1, 7, 'Dance'),
(9, 7, 'Sad'),
(10, 7, 'Romance'),
(11, 9, 'Romance');

-- --------------------------------------------------------

--
-- Table structure for table `playlist_info`
--

CREATE TABLE `playlist_info` (
  `id` int(11) NOT NULL,
  `playlist_id` int(11) DEFAULT NULL,
  `music_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `playlist_info`
--

INSERT INTO `playlist_info` (`id`, `playlist_id`, `music_id`) VALUES
(10, 10, 2),
(11, 1, 2),
(14, 9, 2),
(15, 9, 39),
(16, 10, 46),
(17, 11, 6),
(18, 1, 52);

-- --------------------------------------------------------

--
-- Table structure for table `temp`
--

CREATE TABLE `temp` (
  `splitted_columns` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temp`
--

INSERT INTO `temp` (`splitted_columns`) VALUES
('asd'),
('asd'),
(' dsa'),
('asd'),
('asd'),
('Atif Aslam'),
('Sreenam'),
('DJ Alvee'),
('JAM8'),
(' Arijit Singh '),
(' Harshdeep Kaur'),
('Mohit Chauhan '),
(' Tarannum Mallik'),
('Aastha Gill'),
(' Badshah'),
('Sunidhi Chauhan'),
('fffff\r\n		'),
('dddfdf'),
('fddf'),
('fdffd'),
('fdfd'),
('fdf'),
('Kumar Sanu'),
(' Udit Narayan'),
('Vishal Dadlani'),
(' Shalmali Kholgade'),
(' Balraj Sahani '),
(' Kishore Kumar'),
('Dharmendra'),
(''),
(' Amitabh Bachchan'),
(' Hema Malini'),
('Salman Khan'),
('Aishwarya Rai'),
('Alka Yagnik'),
('Anuradha Paudwal '),
(' Aamir Khan'),
('Arigit Singh'),
('Joe-Emrold-Owamos'),
('Traevus-Owamos'),
(''),
('singh-sings'),
('jagjit-singh'),
('Khaligraph Jones'),
('Dizasta Vina'),
('Pankaj Udhas'),
('Pankaj Udhas-'),
('Niranjan Pandya'),
('Niranjan Pandya'),
('');

--
-- Triggers `temp`
--
DELIMITER $$
CREATE TRIGGER `insert_into_artists` AFTER INSERT ON `temp` FOR EACH ROW BEGIN
	insert into artists(`name`) SELECT DISTINCT TRIM(`splitted_columns`) FROM temp where TRIM(`splitted_columns`) not in(select `name` from artists);
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userid` int(10) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `cpassword` varchar(50) NOT NULL,
  `is_admin` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userid`, `firstname`, `lastname`, `username`, `email`, `password`, `cpassword`, `is_admin`) VALUES
(7, 'Deep', 'Ramani', 'dsp_ramani', 'deepramani8505@gmail.com', 'deep', 'deep', 1),
(9, 'biren', 'chauhan', 'biren_chauhan', 'biren@gmail.com', 'biren', 'biren', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`,`name`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favourite`
--
ALTER TABLE `favourite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `music_id` (`music_id`);

--
-- Indexes for table `music`
--
ALTER TABLE `music`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_fk` (`category_id`);

--
-- Indexes for table `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `playlist_info`
--
ALTER TABLE `playlist_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `playlist_id` (`playlist_id`),
  ADD KEY `music_id` (`music_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `favourite`
--
ALTER TABLE `favourite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `music`
--
ALTER TABLE `music`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT for table `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `playlist_info`
--
ALTER TABLE `playlist_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `favourite`
--
ALTER TABLE `favourite`
  ADD CONSTRAINT `favourite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `favourite_ibfk_2` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `music`
--
ALTER TABLE `music`
  ADD CONSTRAINT `category_fk` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `playlist`
--
ALTER TABLE `playlist`
  ADD CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`userid`);

--
-- Constraints for table `playlist_info`
--
ALTER TABLE `playlist_info`
  ADD CONSTRAINT `playlist_info_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`),
  ADD CONSTRAINT `playlist_info_ibfk_2` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
