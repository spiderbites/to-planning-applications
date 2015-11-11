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

CREATE TABLE IF NOT EXISTS `parse` (
  `folderYear` int(11) NOT NULL,
  `folderSequence` varchar(10) NOT NULL,
  `folderSection` varchar(10) NOT NULL,
  `folderRevision` varchar(10) NOT NULL,
  `folderType` varchar(10) NOT NULL,
  `communityInfo` varchar(255) NOT NULL,
  `folderDescription` text NOT NULL,
  `folderRsn` int(11) NOT NULL,
  `folderTypeDesc` varchar(255) NOT NULL,
  `folderTypeList` varchar(255) NOT NULL,
  `geoID` int(11) NOT NULL,
  `inDate` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `mainProperty` int(11) NOT NULL,
  `maxOutcome` int(11) NOT NULL,
  `propX` double NOT NULL,
  `propY` double NOT NULL,
  `referenceFile` varchar(255) NOT NULL,
  `statutoryInfo` varchar(255) NOT NULL,
  `subType` varchar(255) NOT NULL,
  `plannerName` varchar(255) NOT NULL,
  `plannerPhone` varchar(255) NOT NULL,
  `legalDesc` varchar(255) NOT NULL,
  `planningWard` int(11) NOT NULL,
  `postal` varchar(10) NOT NULL,
  `propertyRoll` varchar(255) NOT NULL,
  `propertyRsn` int(11) NOT NULL,
  `region` varchar(100) NOT NULL,
  `proposal-bachelor` int(11) NOT NULL,
  `proposal-bedroom1` int(11) NOT NULL,
  `proposal-bedroom2` int(11) NOT NULL,
  `proposal-bedroom3plus` int(11) NOT NULL,
  `proposal-condo` int(11) NOT NULL,
  `proposal-existingBuildings` int(11) NOT NULL,
  `proposal-existingNonResGFA` int(11) NOT NULL,
  `proposal-existingResidGFA` int(11) NOT NULL,
  `proposal-existingResUnits` int(11) NOT NULL,
  `proposal-existingStoreys` int(11) NOT NULL,
  `proposal-existingTotal` int(11) NOT NULL,
  `proposal-freehold` int(11) NOT NULL,
  `proposal-proposedBuildings` int(11) NOT NULL,
  `proposal-proposedGFA` int(11) NOT NULL,
  `proposal-proposedLandUse` varchar(100) NOT NULL,
  `proposal-proposedNonResGFA` int(11) NOT NULL,
  `proposal-proposedResidGFA` int(11) NOT NULL,
  `proposal-proposedResUnits` int(11) NOT NULL,
  `proposal-proposedStoreys` int(11) NOT NULL,
  `proposal-proposedTotalGFA` int(11) NOT NULL,
  `proposal-rental` int(11) NOT NULL,
  `proposal-rooms` int(11) NOT NULL,
  `proposal-totalGrossFloorArea` int(11) NOT NULL,
  `proposal-totalNonResGFA` int(11) NOT NULL,
  `proposal-totalResidGFA` int(11) NOT NULL,
  `maxStageOutcome-applicationRsn` int(11) NOT NULL,
  `maxStageOutcome-applicationTypeDesc` varchar(100) NOT NULL,
  `maxStageOutcome-comments` text NOT NULL,
  `maxStageOutcome-decisionDesc` varchar(255) NOT NULL,
  `maxStageOutcome-outcomeCode` int(11) NOT NULL,
  `maxStageOutcome-outcomeDate` varchar(40) NOT NULL,
  `maxStageOutcome-outcomeDesc` varchar(100) NOT NULL,
  `maxStageOutcome-outcomeRsn` varchar(100) NOT NULL,
  `maxStageOutcome-stageDesc` varchar(100) NOT NULL,
  `maxStageOutcome-statusLinkFlag` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
