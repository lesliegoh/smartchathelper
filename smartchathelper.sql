CREATE DATABASE  IF NOT EXISTS "smartchathelper" /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `smartchathelper`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: irs-project-db-do-user-1904386-0.b.db.ondigitalocean.com    Database: smartchathelper
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '4b8eea90-9a0b-11ec-9fa2-d2a962a41fa6:1-20,
62d59d4c-30bb-11ec-bd8e-42bd39d164b4:1-528613,
79201058-8dd0-11eb-b545-e20a2d2679c7:1-642443,
b151c970-aa8b-11ec-b9ad-661c69d6d573:1-39';

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `roomMessageID` int NOT NULL AUTO_INCREMENT,
  `accountID_FK` int DEFAULT NULL,
  `userID_FK` int DEFAULT NULL,
  `dateCreated` timestamp NULL DEFAULT NULL,
  `message` text,
  `isDeleted` tinyint DEFAULT NULL,
  `isPicture` tinyint DEFAULT '0',
  `isFile` int DEFAULT '0',
  `pictureLabel` varchar(100) DEFAULT NULL,
  `fileSummary` text,
  PRIMARY KEY (`roomMessageID`)
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (197,75,1,'2022-04-25 23:37:24','<p>This conversation is about Design for this Deal</p>\n',0,0,0,NULL,NULL),(198,75,1,'2022-04-26 19:45:44','<p>The Hans Zimmer produced soundtrack for the 25th installment in the James Bond film franchise, No Time To Die. The soundtrack will include Billie Eilish&#39;s electrifying title track No Time To Die, co-written (with brother Finneas O&#39;Connell) and performed by Eilish. Joining Zimmer on scoring the soundtrack is Johnny Marr, who is also the featured guitarist on the album, with additional music by composer and score producer Steve Mazzaro.</p>\n',0,0,0,NULL,NULL),(199,75,1,'2022-05-03 01:43:12','<p>test</p>\n',0,0,0,NULL,NULL),(200,75,1,'2022-05-03 05:02:42','<p>Another message</p>\n',0,0,0,NULL,NULL),(201,75,1,'2022-05-03 05:05:09','<p>One more test message</p>\n',0,0,0,NULL,NULL),(202,75,1,'2022-05-03 05:05:09','<p>One more test message</p>\n',0,0,0,NULL,NULL),(203,75,1,'2022-05-03 05:13:09','<p>Yesterday, I created a simple, useless chat app to study the asynchronous bidirectional connection with PHP.</p>\n\n<p>You can use it here, and get the source code here (I don&#39;t understand enough what it means to disclose the server-side script. I wanna show the beginners an example with SSE and believe there&#39;s no vuln and no one wouldn&#39;t do something bad :))</p>\n\n<p>At first, I wanted to learn WebRTC and coded, but the code didn&#39;t work because of the hard restriction of my shared server. So, I tried some techs, and I found the SSE works properly.</p>\n',0,0,0,NULL,NULL),(204,75,1,'2022-05-03 05:18:47','<p>test</p>\n',0,0,0,NULL,NULL),(205,75,6,'2022-05-04 22:31:04','<p>If the array size is small , the server side can get the querystring. But if the array size is big. (maybe over thousands of characters), the server can&#39;t get the querystring. Is it possible to use POST method in new EventSource(...) to to pass the json array to server that can avoid the querystring length limitation?</p>\n',0,0,0,NULL,NULL),(206,75,6,'2022-05-05 22:14:06','<p>Test today</p>\n',0,0,0,NULL,NULL),(207,75,6,'2022-05-05 22:27:20','<p>Anoter test</p>\n',0,0,0,NULL,NULL),(208,75,1,'2022-05-05 22:31:02','<p>A test on Microsoft Edge</p>\n',0,0,0,NULL,NULL),(210,75,1,'2022-05-05 22:33:01','<p>Below is an example of a single media object. Only two classes are required&mdash;the wrapping .media and the .media-body around your content. Optional padding and margin can be controlled through spacing utilities.</p>\n',0,0,0,NULL,NULL),(211,75,6,'2022-05-05 22:33:29','<p>Across this new divide</p>\n',0,0,0,NULL,NULL),(212,75,1,'2022-05-05 22:34:36','<p>Standing on the frontline when the bombs start to fall. Heaven is jealous of our love, angels are crying from up above. Can&#39;t replace you with a million rings. Boy, when you&#39;re with me I&#39;ll give you a taste. There&rsquo;s no going back. Before you met me I was alright but things were kinda heavy. Heavy is the head that wears the crown.</p>\n',0,0,0,NULL,NULL),(213,75,1,'2022-05-06 23:37:47','<p>One test today</p>\n',0,0,0,NULL,NULL),(215,75,6,'2022-05-06 23:41:31','<p>one of the issues is that when a new conversation is added, we do not know whether there are any other new conversations before this added by another person</p>\n',0,0,0,NULL,NULL),(216,75,6,'2022-05-06 23:41:43','<p>-&gt; each time a new conversation is added, call check conversation<br />\n-&gt; hidden field of latest message ID?<br />\n-&gt; ajax function that calls check conversation and loads latest messages without refreshing</p>\n',0,0,0,NULL,NULL),(217,75,1,'2022-05-06 23:43:50','<p>Conveying meaning to assistive technologies<br />\nUsing color to add meaning only provides a visual indication, which will not be conveyed to users of assistive technologies &ndash; such as screen readers. Ensure that information denoted by the color is either obvious from the content itself (e.g. the visible text), or is included through alternative means, such as additional text hidden with the .sr-only class.</p>\n',0,0,0,NULL,NULL),(218,75,6,'2022-05-06 23:44:12','<p>another test</p>\n',0,0,0,NULL,NULL),(219,75,6,'2022-05-07 00:28:17','<p>One step at a time</p>\n',0,0,0,NULL,NULL),(220,75,1,'2022-05-07 00:29:20','<p>Yes you are right</p>\n',0,0,0,NULL,NULL),(221,75,6,'2022-05-07 00:29:44','<p>Note that depending on how they are used, badges may be confusing for users of screen readers and similar assistive technologies. While the styling of badges provides a visual cue as to their purpose, these users will simply be presented with the content of the badge. Depending on the specific situation, these badges may seem like random additional words or numbers at the end of a sentence, link, or button.</p>\n\n<p>Unless the context is clear (as with the &ldquo;Notifications&rdquo; example, where it is understood that the &ldquo;4&rdquo; is the number of notifications), consider including additional context with a visually hidden piece of additional text.</p>\n',0,0,0,NULL,NULL),(222,75,1,'2022-05-08 17:41:23','<p>Test</p>\n',0,0,0,NULL,NULL),(223,75,6,'2022-05-08 17:41:41','<p>Ok we have another test here</p>\n',0,0,0,NULL,NULL),(224,75,1,'2022-05-08 17:42:13','<p>In the code above:</p>\n\n<p>We placed our Ajax request inside a custom function called send. You can name this as something else if you wish.<br />\nInside the success function of our Ajax request, we use the setTimeout method. Here, we specify that we want to send another request 10 seconds after the current request has been successfully completed. This means that the script we are sending the request to should only receive 1 request every 10 seconds at most.</p>\n',0,0,0,NULL,NULL),(225,75,1,'2022-05-08 18:00:30','<p>This solution relies on the first call to be a success. If at any point in time your code doesn&#39;t &quot;succeed&quot; (perhaps there was a server hiccup?), your &quot;polling&quot; will stop until a page refresh.</p>\n\n<p>You could use setInterval to call that method on a defined interval, which avoids this problem:</p>\n',0,0,0,NULL,NULL),(226,75,6,'2022-05-08 18:03:14','<p>Is that so?</p>\n',0,0,0,NULL,NULL),(227,75,1,'2022-05-08 18:03:47','<p>With both solutions, your server will be handling a lot of requests it might not need to. You can use a library like PollJS (shameless self plug) to add increasing delays, which will increase performance and decrease bandwidth:</p>\n',0,0,0,NULL,NULL),(228,75,1,'2022-05-08 18:18:37','<p>Testing again</p>\n',0,0,0,NULL,NULL),(236,75,1,'2022-05-09 17:32:12','<p>Bootstrap&rsquo;s modal class exposes a few events for hooking into modal functionality. All modal events are fired at the modal itself (i.e. at the &lt;div class=&quot;modal&quot;&gt;).</p>\n',0,0,0,NULL,NULL),(238,75,6,'2022-05-09 23:29:13','<p>Ok got it. Will be attending</p>\n',0,0,0,NULL,NULL),(239,75,1,'2022-05-09 23:29:56','<p>Thank you. Please remember to bring your laptop.</p>\n',0,0,0,NULL,NULL),(240,75,6,'2022-05-09 23:35:50','<p>Yes I will</p>\n',0,0,0,NULL,NULL),(241,75,1,'2022-05-09 23:37:35','<p>Thanks</p>\n',0,0,0,NULL,NULL),(242,75,6,'2022-05-09 23:38:32','<p>Welcome. Do you need me to prepare the powerpoint as well?</p>\n',0,0,0,NULL,NULL),(243,75,1,'2022-05-09 23:40:44','<p>No need. You can get from Cath.</p>\n',0,0,0,NULL,NULL),(244,75,6,'2022-05-09 23:56:13','<p>Got it</p>\n',0,0,0,NULL,NULL),(302,75,1,'2022-05-16 15:12:45','Thank you all for attending the meeting. Please get Cath to hand out the minutes.',0,0,0,NULL,NULL),(303,75,1,'2022-05-16 17:24:01','iiqtslzmmf.jpg',0,1,0,'rocket\n',''),(304,75,1,'2022-05-16 17:41:39','agqeuqnimz.jpg',0,1,0,'deer\n',''),(305,75,1,'2022-05-16 20:55:43','learningguide-writingaresearchreport.pdf',0,0,1,'','Methodology Results Discussion Conclusion Recommendations (sometimes included in the Conclusion) References or Bibliography Concise heading indicating what the report is about List of major sections and headings with page numbers Concise summary of main findings What you researched and why Other relevant research in this area What you did and how you did it What you found Relevance of your results, how it fits with other research in the area Summary of results/findings What needs to be done as a result of your findings All references used in your report or referred to for background information Appendices Any additional material which will add to your report STEP 1 Analyse the Task As with any assignment task, you must first analyse what is expected of you. Methodology Results Discussion Conclusion Recommendations (sometimes included in the Conclusion) References or Bibliography Appendices WRITING CENTRE Level 3 East, Hub Central North Terrace campus, The University of Adelaide ph +61 8 8313 3021 writingcentre@adelaide.edu.au www.adelaide.edu.au/writingcentre/ Table 2: Content of individual sections Individual Sections Content of Each Section Title of Report Table of Contents (not always required)Refer to the tables below: Table 1: Divisions and sections of a report Broad Divisions (1) Preliminary material (2) Body of report (3) Supplementary material Individual Sections Title of Report Table of Contents (not always required) STEP 5 Draft the Supplementary Material  References or Bibliography - This includes all references used in your report or referred to for background information. STEP 4 Draft the Body of Your Report  Introduction - The purpose of your report. Abstract/Synopsis Introduction Literature Review (sometimes included in the Introduction)\n'),(306,75,1,'2022-05-16 21:14:09','the_childrens_story_becken_presentation.pdf',0,0,1,'','One of my teachers at the other school I went to before this one,\" Joan said in a rush, \"well, she sort of said what it all meant, at least she said some thing about it just before recess one day and then the bell went and afterwards we had spellin\'.\" She went softly back to her desk and the prayer ended, and So, following their New Teacher, they all closed their eyes the children opened their eyes and they stared at the candy and steepled their hands together, and they prayed with her and they were overjoyed. from inside your tummies,\" the New Teacher said radiantly, \"and good strong children like you have to put food in your The New Teacher shut the door behind Miss Worden and turned back into the room, cradling Sandra in her arms. The New Teacher found the scissors and then they had to decide who would be allowed to cut a little piece off, and the New Teacher said that because today was Mary\'s birthday (HOW DID YOU KNOW THAT?) smelled the perfume of her - clean and fresh and young - \"Just because THEY\'VE conquered us there\'s no need for and as she passed Sandra who sat at the end of the first row panic fear,\" Dad had said.So you know that it doesn\'t matter whom you ask, whom you shut your eyes and They all nodded happily and popped the candy into their \'pray\' to -- to God or anyone, even Our Leader -no one will mouths and chewed gloriously.He \"Good morning, children, I\'m your new teacher,\" the New did not understand anything except that the teacher was Teacher said. The New Teacher said, \"We\'re going -to have lots of Johnny sat back contentedly, resolved to work hard and listen and not to have wrong thoughts like Dad.The children found this \"He just wants to talk to you, Miss Worden,\" the New very strange, for THEY were foreigners from a strange Teacher said gently. And she sat down on the floor as gracefully as an angel, Sandra in her arms, and she began to sing and the children \"Now,\" said the New Teacher, \"what shall we do?She looked at it a moment and then said, \"I wish I could have a So the flag was cut up by the children and they were very proud that they each had a piece. \"I\'m going to pray to Our Leader every time,\" Mary said The New Teacher opened her eyes and looked around excitedly.Then she closed the door softly and walked to afraid, and because she was afraid she was making them all the teacher\'s desk, and the children in the front row felt and worse and he wanted to shout that there was no need to fear. In the mists of her mind she saw the rows upon rows of As the book\'s blurb says, The Children\'s Story is not just for children she had taught through her years. The New Teacher got up from her seat and walked the length of the room and the children\'s eyes followed her, and Johnny stood, knees of jelly.And then they When they were all back in their seats the new Teacher said, \"Well, before we start our lessons, perhaps there are some questions you want me to answer. The New Teacher sang the song again, and soon all the 2 children were happy and calm once more. But she was warmed not by the sun but by the thought that throughout the school and throughout the land all children, all men and all women were being taught with the same faith, with variations of the same procedures.\"We first pledge allegiance and then we sing the song -\" \"Yes, but that\'s all after roll call,\" Sandra said, \"You forgot roll call. And the other children nodded, and they wondered if all their parents should go back to school and unlearn bad thoughts. \"Well, perhaps sometime when you wanted to talk about something very important to your dad, perhaps he said, \'Not now, Johnny, I\'m busy,\' or, \'We\'ll talk about that tomorrow.\' Mary shrugged helplessly and looked at her best friend, Hilda, who looked back at her and then at the teacher and we don\'t need roll call while I\'m your teacher.But most children were agonized by the cut to her voice, and one or important, she wore a lovely smile, and when she spoke, she two of them felt the edge of tears.This was what she had been trained for, and she knew that she would teach her children well and that they would grow up to be good citizens.It was a child\'s song, and it soothed them, and after yes, somehow she already knew Sandra\'s name, but how she had sung the first chorus the New Teacher told them the could she possibly know everyone\'s?Set The teacher glanced numbly from the door and stared at the in a classroom, it shows how susceptible young minds are, flag which stood in a corner of the room. met a fine man riding a fine horse and the man told them that there was never a need to be afraid, for all they had to do was the watch the stars and the stars would tell them where their home was.You sort of pledge you\'re going to do something like not suck your thumb \'cause that makes your teeth bend and you\'ll have to wear a brace and go to the dentist, which hurts.\"They listened never did this, and often she called a child by another\'s spellbound to the happy lilt of the New Teacher\'s voice and name.They \"Thank you, Mary dear, but I just wanted a little piece of this shrieked with excitement as they saw it bounce on the one because it\'s our own special classroom one.\" wondered why he hadn\'t figured that out for himself before asking, astonished that she had worked three days just to know everyone the first day.Just because the other children want to wear new clothes, you don\'t have to,\" the new Teacher said.Then we can share knowledge, and I can learn from you as you will learn from \"Oh, good,\" the children said. \"The other schools I went to,\" Hilda said, \"they never said anything about it.But let\'s pray for something very So the children shut their eyes tightly and prayed very hard, good.She had never brainwashing a classroom of children, turning them against had children of her own. Mary said, after a silence, \"We never got to ask our real teacher ANY questions.\"They began to love this strange New Then Danny said, \"If we had some scissors we could cut a Teacher.But only if you promise to go right to sleep Because the New Teacher was disappointed, the children afterward.\" you think about when the lights are out and Mommy and \"Hello, Miss Worden,\" the New Teacher said.Mary said, \"But it\'ll cost a lot, and my momma won\'t want to spend the money \'cause we have to buy food and food is expen--If you she said, \"Good morning, Sandra,\" and Sandra flushed fear too much, you\'ll be dead even though you\'re alive.\"She was blinded by her terror, not only (and just 25 minutes), a silky voiced teacher succeeds in for herself but mostly for them, her children.Now all your daddies will \"If you like, children, as a very special surprise, you can all be home soon.\"\n');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `accountID` int DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'John','Tan','John Tan','tester@smartappchat.com','smartappchatpassword',75);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-17 20:00:03
