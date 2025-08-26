# Kaleidoscope Bat Data Compiler
An R program built as apart of a volunteer project with PhD Candidate Robin Rowland at the University of the Sunshine Coast.
Created by Ryley Delaney February 2025

## Table of Contents  
- [Overview](#overview)
- [Task Description](#task-description)
- [Scripts](#scripts)
- [Packages](#packages)
- [Usage](#usage)


## Overview
<p>This Repository contains scripts that allow the compilation of several CSV's of data that has been exported from the  <a href=https://www.wildlifeacoustics.com/products/kaleidoscope-pro> Kaleidoscope Pro Analysis Software </a> into a single CSV while simultaneously editing ID's and adding groups/categories. In this example, the data contained common names for local bat species and provided an interactive tool that stepped the user through renaming all common names to scientific names after which it added each bat to a guild.</p>

You can view Robin Rowland's LinkedIn <a href="https://www.linkedin.com/in/robin-rowland-3b16a3152/?originalSubdomain=au"> here </a> </p>
<p> The example report is in HTML format and will need to be downloaded to be viewed properly if attempting to view from GitHub.</p>

<br>

## Task Description
<p>I approached Robin with the personal goal of obtaining better skills in data analysis and research. She set me out with a series of small tasks to aid in an overarching goal to attempt to better understand means of estimating likelihood of bat activity without being on-site, to aid in the monitoring of bats remotely.</p>
<ol>
<li> Read through a provided list of papers on bat activity, identify what data was collected, the methods used and what variables were relevant and important.</li>  
<li> Collate and analyse the information researched: <i>were some bats more influenced by some variables than others? What variables could be monitored remotely such as humidity and temperature?</i></li>
<li> Using the data already taken from previous surveys, clean up any common names or mispellings and assign guilds to each species.</li>
</ol>
<p> When approaching the third task I pointed out that I believe its well within the scope of R to automate this cleanup, and that if kaleidoscope has a consistent format in its data output it could be applied generally to other survey data. Thus birthed this repository and program.</p>

<br><br>

## Scripts
<h4>Main.R </h4>
The main script of the repository, loads all packages, and sources all functions. The script requires integrating inputs from the user on renaming names that don't exist in a 'Species_Translations.csv' file.
<br><br>
<h4> Functions.R </h4>
Contains all the functions that are necessary for Main.R to run.

<br><br>

## Packages
This program uses a few packages which will need to be installed in order to run.
<ul>
<li> <b>data.table</b>
<li> <b>tidyverse</b>
</ul>

<br><br>

## Usage

<p>For this project I provided a readme.docx via email which I've added to the repository. The readme provides a clear step through on how to setup and work the program from the project.</p>
