<center>
<p>
  <b style="font-size: 1.5em">Shared-bike services: from open data platforms to a dataviz application</b>
</p>
  </br>
  <div style="font-size: 0.9em">FOSS4G2019 - Bucharest</div>
  </br>
  <em style="font-size: 0.7em">Raphaël Delhome(*), Damien Garaud</em>
  </div>
  <br>
  <img src="./img/foss4g-2019-bucharest.jpg" width="40%">
</center>

<!-- .slide: data-background="img/oslbackground.png" data-background-size="650px" -->
<!-- -->

---

## Introduction
<!-- .slide: data-background="img/oslbackground.png" data-background-size="650px" -->
<!-- -->

---

### Shared-bike services

<div id="left">
  <img src="./img/velov.jpg" width="100%">
  <a href="https://velov.grandlyon.com/">Velo'v (Lyon)</a>
</div>
<!-- .element: class="fragment" data-fragment-index="1" -->

<div id="right">
  + Shared-bike rental service in large cities
  + Small-duration rents
  + Stations and availability
</div>
<!-- .element: class="fragment" data-fragment-index="0" -->

---

### Major challenges

+ Bike (resp. bike stand) availability ?
+ Bike-sharing station classification ?
+ Data pipeline design ?
<!-- .element: class="fragment" data-fragment-index="1" -->

<img src="./img/pipeline.jpg" width="30%">
<!-- .element: class="fragment" data-fragment-index="1" -->

---

## Outline

<p data-markdown><em>(Part 1)</em> Handle open geospatial data</p>
<p data-markdown><em>(Part 2)</em> Bike-sharing station unsupervised classification</p>
<p data-markdown><em>(Part 3)</em> Bike and station short-term availability prediction</p>
<p data-markdown><em>(Part 4)</em> Web application demo</p>

---

## Data overview
<!-- .slide: data-background="img/oslbackground.png" data-background-size="650px" -->
<!-- -->

---

### Open geospatial data

+ <a href="https://data.grandlyon.com/">Lyon, France</a>
<img src="./img/logo_grandlyon.png" width="70%">
+ <a href="http://opendata.bordeaux.fr/">Bordeaux, France</a>
<!-- .element: class="fragment" data-fragment-index="1" -->
<img src="./img/logo_metropolebordeaux.png" width="70%">
<!-- .element: class="fragment" data-fragment-index="1" -->

---

### Which data?

id | bs | abs | ab | status | last_timestamp
---|---|---|---|---|---|---
10063 | 34 | 10 | 23 | OPEN | 2017-07-08 23:49:09
10021 | 19 | 0 | 0 | CLOSED | 2017-07-08 00:30:12
8038 | 20 | 6 | 14 | OPEN | 2017-07-08 23:49:26
7045 | 20 | 13 | 7 | OPEN | 2017-07-08 23:52:43

---

### General Bikeshare Feed Specification

https://github.com/NABSA/gbfs

<img src="./img/gbfs.png" width="60%">
<!-- .element: class="fragment" data-fragment-index="1" -->

---

### Data pipeline

+ Build a Python data pipeline thanks to <a href="https://luigi.readthedocs.io/en/stable/">Luigi</a>
+ Get, transform and store the data
  - get data every five minutes (`json`, `shp`)
  - in-base storage (`PostgreSQL`+`Postgis`)
  - feature engineering and ML treatments

<img src="./img/etl_graph.png" width="60%">

---

## Bike-sharing station classification
<!-- .slide: data-background="img/oslbackground.png" data-background-size="650px" -->
<!-- -->

---

### Objective

+ Classify bike-sharing station according to their usage by customers

+ <em>Main idea =</em> group stations that look similar
<!-- .element: class="fragment" data-fragment-index="1" -->

+ ... <em>What does it mean?</em> => Focus on the time series
<!-- .element: class="fragment" data-fragment-index="2" -->

<img src="./img/lyon_timeseries_170709.png" width="30%">
<!-- .element: class="fragment" data-fragment-index="2" -->

---

### K-means clustering

<div id="left">
<ul>
<li> Inspired from <a href="https://towardsdatascience.com/usage-patterns-of-dublin-bikes-stations-484bdd9c5b9e">a similar work of James Lawlor</a>
 </li>
<li> One profile = one individual </li>
<li> Group similar individuals together </li>
<li> Deduce stations profiles </li> </ul> 
</div>

<div id="right">
  <img src="./img/lyon-pattern.png" width="100%">
  *ex:* 4 clusters in Lyon
</div>
<!-- .element: class="fragment" data-fragment-index="1" -->

---

### Clustered station mapping

<img src="./img/lyon-4-clusters.png" width="70%">

---

## Shared-bike availability prediction
<!-- .slide: data-background="img/oslbackground.png" data-background-size="650px" -->
<!-- -->

---

### Objective

+ Know if some bikes (<em>resp.</em> stations) will be available in the next few minutes

+ <em>Main idea =</em> Predict **future** availability with availability **history**
<!-- .element: class="fragment" data-fragment-index="1" -->

+ ... <em>What does it mean?</em> => Supervised learning to learn an availability probability
<!-- .element: class="fragment" data-fragment-index="2" -->

---

### XGBoost method

<div id="left">
  Use a boosting tree method :
  <ul>
  <li>to predict <b>Y</b> (availability probability at H+1)</li>
  <li>starting from <b>X</b> (hour, day, available bikes at H, ...)</li>
  </ul>
</div><!-- .element: class="fragment" data-fragment-index="1" -->

<div id="right">
  <img src="./img/gbt_example.jpg" width="100%">
</div>
<!-- .element: class="fragment" data-fragment-index="2" -->

---

### Results

<div id="right">
  Without tuning features, RMSE = 0.095

  <img src="./img/lyon_prediction_error.png" width="100%">
  <font size="6"> (^) Error </font>
</div>
<!-- .element: class="fragment" data-fragment-index="1" -->

<div id="left"> 
  <img src="./img/lyon_prediction.png" width="80%">
 <br>
 <font size="6">(^) Prediction; Ground-truth (v)</font>
  <img src="./img/lyon_groundtruth.png" width="80%">
</div>



---

## Demo
<!-- .slide: data-background="img/oslbackground.png" data-background-size="650px" -->
<!-- -->

Web application: <a href="http://data.oslandia.io/bikes/">http://data.oslandia.io/bikes/</a>

---

## Conclusion
<!-- .slide: data-background="img/oslbackground.png" data-background-size="650px" -->
<!-- -->

---

### Conclusion and perspectives

+ Addressing some simple research questions with some open geospatial dataset
+ From data source to database (ETL-like) with <a href="https://luigi.readthedocs.io/en/stable/">Luigi</a>
+ Production of an API to visualize data => towards production?
+ Online learning: keep on gathering data, and learn continuously

---

## Thanks for your attention!

Questions?

<a href="mailto:damien.garaud@oslandia.com">damien.garaud@oslandia.com</a>
<a href="mailto:raphael.delhome@oslandia.com">raphael.delhome@oslandia.com</a>
<!-- .slide: data-background="img/oslbackground.png" data-background-size="650px" -->
<!-- -->

See more on <a href="http://oslandia.com/en/blog/">Oslandia's blog</a> and on <a href="https://github.com/garaud/jitenshea">github.com/garaud/jitenshea</a>
