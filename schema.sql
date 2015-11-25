-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 03, 2015 at 09:33 PM
-- Server version: 5.5.44
-- PHP Version: 5.3.10-1ubuntu3.19



SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `toplanapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `parse`
--

DROP TABLE IF EXISTS `parse`;

CREATE TABLE IF NOT EXISTS `parse` (
  `folderYear` int(11),
  `folderSequence` varchar(10),
  `folderSection` varchar(10),
  `folderRevision` varchar(10),
  `folderType` varchar(10),
  `communityInfo` varchar(255),
  `folderDescription` text,
  `folderRsn` int(11),
  `folderTypeDesc` varchar(255),
  `folderTypeList` varchar(511),
  `geoID` int(11),
  `inDate` varchar(100),
  `location` varchar(100),
  `mainProperty` int(11),
  `maxOutcome` int(11),
  `propX` double,
  `propY` double,
  `referenceFile` varchar(255),
  `statutoryInfo` varchar(255),
  `subType` varchar(255),
  `plannerName` varchar(255),
  `plannerPhone` varchar(255),
  `legalDesc` varchar(255),
  `planningWard` int(11),
  `postal` varchar(10),
  `propertyRoll` varchar(255),
  `propertyRsn` int(11),
  `region` varchar(100),
  `proposal` varchar(100),
  `proposal_bachelor` int(11),
  `proposal_bedroom1` int(11),
  `proposal_bedroom2` int(11),
  `proposal_bedroom3plus` int(11),
  `proposal_condo` int(11),
  `proposal_existingBuildings` int(11),
  `proposal_existingNonResGFA` int(11),
  `proposal_existingResidGFA` int(11),
  `proposal_existingResUnits` int(11),
  `proposal_existingStoreys` int(11),
  `proposal_existingTotal` int(11),
  `proposal_folderRsn` int(11),
  `proposal_freehold` int(11),
  `proposal_proposedBuildings` int(11),
  `proposal_proposedGFA` int(11),
  `proposal_proposedLandUse` varchar(100),
  `proposal_proposedNonResGFA` int(11),
  `proposal_proposedResidGFA` int(11),
  `proposal_proposedResUnits` int(11),
  `proposal_proposedStoreys` int(11),
  `proposal_proposedTotalGFA` int(11),
  `proposal_rental` int(11),
  `proposal_rooms` int(11),
  `proposal_totalGrossFloorArea` int(11),
  `proposal_totalNonResGFA` int(11),
  `proposal_totalResidGFA` int(11),
  `proposal_other` int(11),
  `maxStage` int(11),
  `maxStage_folderRsn` int(11),
  `maxStage_stageFlag` int(11),
  `maxStage_stageRsn` int(11),
  `maxStage_stageCode` int(11),
  `maxStage_stageCodeDesc` varchar(100),
  `maxStage_stageDate` varchar(100),
  `maxStage_maxStageOutcome` varchar(100),
  `maxStageOutcome_applicationRsn` int(11),
  `maxStageOutcome_applicationTypeDesc` varchar(100),
  `maxStageOutcome_comments` text,
  `maxStageOutcome_decisionDesc` varchar(255),
  `maxStageOutcome_outcomeCode` int(11),
  `maxStageOutcome_outcomeDate` varchar(40),
  `maxStageOutcome_outcomeDesc` varchar(100),
  `maxStageOutcome_outcomeRsn` varchar(100),
  `maxStageOutcome_stageDesc` varchar(100),
  `maxStageOutcome_statusLinkFlag` varchar(100),
  `plannerInfo` varchar(100),
  `plannerInfo_plannerPhone` varchar(100),
  `plannerInfo_plannerName` varchar(100),
  `plannerInfo_plannerTitle` varchar(100),
  `plannerInfo_emailAddress` varchar(100),
  `propertyView_postal` varchar(100),
  `propertyView_planningDistrict` varchar(100),
  `propertyView_province` varchar(100),
  `propertyView_propertyRsn` int(11),
  `propertyView_street` varchar(100),
  `propertyView_planningWard` int(11),
  `propertyView_folders` int(11),
  `propertyView_city` varchar(100),
  `propertyView_streetDirection` varchar(100),
  `propertyView_streetType` varchar(100),
  `propertyView_address` varchar(100),
  `propertyView_wardDesc` varchar(100),
  `propertyView_region` varchar(100),
  `propertyView_legalDesc` varchar(200),
  `propertyView_propertyRoll` varchar(100),
  `propertyView_house` varchar(100),
  `ward_queried` int(11)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE  `parse` ADD PRIMARY KEY (  `folderYear` ,  `folderSequence` ,  `folderSection` ,  `folderRevision` ,  `folderType` );

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
