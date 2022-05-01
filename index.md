<script src="js/goal_graph.js"></script>
<script src="js/formations.js"></script>
<title>Footy Viz</title>
<header class="page-header" role="banner">
	<div class="intro-to-page">
		<h1 class="project-tagline">England's Soccer Superstars</h1>
		<h2 class="project-tagline">Advait Lad, Akshar Dhondiyal, Tim Schott &nbsp; Info Viz Spring 2022 UC Berkeley</h2>
		<a href="https://github.com/timschott/footy-viz" class="btn">View on GitHub</a>
	</div>
	<div class="nav-links">
		<ul class="nav-menu" id="nav-menu">
			<li>&nbsp;&nbsp;</li>
			<li><a href="#introduction" id="intro-nav">Introduction</a></li>
			<li>&nbsp;|&nbsp;</li>
			<li><a href="#tactics" id ="tactics-nav">Tactics</a></li>
			<li>&nbsp;|&nbsp;</li>
			<li><a href="#harry-kane" id ="kane-nav">Harry Kane</a></li>
			<li>&nbsp;|&nbsp;</li>
			<li><a href="#mason-mount" id ="mount-nav">Mason Mount</a></li>
		</ul>
	</div>
</header>
<body>
	<div class="container" id = "title-container">
		<div class="row">
			<h3>Introduction</h3>
		</div>
	</div>
	<div class="container" id = "intro-container">
		<div class = "row form-group">
			<p>Although the English men's soccer team is one of the oldest national teams in the world, they’ve only won a single major tournament: the 1966 World Cup.</p>
			<p>Can they win this year's 2022 World Cup?</p>
			<p>We'll analyze their squad through a few different perspectives, focusing on 3 key players:</p>
		</div>
	</div>
	<div class="container" id = "card-container">
		<div class = "row form-group">
			<div class="col-lg-4" id ="kane-card">
				<img src="extra/kane_playing_card.png" alt="Harry Kane playing card" class="img-fluid">
			</div>
			<div class="col-lg-4" id ="mount-card">
				<img src="extra/mount_playing_card.png" alt="Mason Mount playing card" class="img-fluid">
			</div>
			<div class="col-lg-4" id ="trent-card">
				<img src="extra/trent_playing_card.png" alt="Trent Alexander-Arnold playing card" class="img-fluid">
			</div>
		</div>
	</div>
	<div class="container" id = "title-frame-for-primer">
		<div class = "row">
			<h3>Contextual Primer</h3>
		</div>
		<div class = "row">
			<h5>How are soccer teams structured?</h5>
		</div>
	</div>
	<div class="container" id = "frame-the-primer">
		<div class = "row">
			<p>Before cracking into these key players, it's important to review some of the basics of the game of soccer and the types of tournaments teams compete in.</p>
			<p>For those already familiar with soccer, feel free to skip ahead to the <a href="#tactics">Tactics</a> section.</p>
			<p>Each team has 11 players. There are two 45 minute halves. The purpose of the game is to score goals against the opposition. Whoever has the most goals at the end of the game wins. It's illegal to use your hands, of course -- which is why most other countries refer to the game as "football."</p>
			<p>Besides the goalkeeper, players fall into 3 broad categories. <i>Forwards</i> are the goal scorers who are the best at shooting and scoring goals. <i>Defenders</i> protect their goal and try to stop opposition forwards from advancing. <i>Midfielders</i> occupy the middle of the field and try to link together the work from their team's defense and make opportunities for the forwards to score.</p>
			<p>Each country organizes its soccer teams into a system of "leagues" similar to the NFL. For example, in England their top soccer league is the "Premier League" and in Germany it is the "Bundesliga." Within those leagues, the teams are typically referred to as <i>clubs</i>.</p>
			<p>The best players from across the world receive the honor to play for their country of origin's <i>national team</i>. The dynamics of each national team are fascinating, then, because players whose "day-jobs" are quite different from one another have to coalesce in short stints of "international breaks" throughout the club soccer season.</p>
			<p>Winning the World Cup is the crown jewel for national teams. It's played every 4 years, and is the most-watched and most-prestigious sporting event in the world.</p> 
			<p>Besides the World Cup, another major tournament England competes in is the European Cup ("The Euros") which is also played every 4 years.</p>
			<p>To get a better sense of what a soccer team looks lke in action, we're going to introduce a few videos and screencaps from matches.</p>
		</div>
	</div>
	<div class="container" id = "primer">
		<div class = "row">
			<h3>Match Footage</h3>
		</div>
		<div class = "row">
			<h5>How are soccer teams structured?</h5>
		</div>
		<div class = "col">
			<p>This is footage from a club match in Germany. The team in blue, Hoffenheim, are trying to advance the ball upfield. 3 defenders are supported by a large group of 5 midfielders along with the 2 attacking forwards.</p>
			<div class="embed-responsive embed-responsive-16by9">
			<iframe embed-responsive-item src="https://www.youtube.com/embed/uY6tgCNg-cU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			</div>
		</div>
		<div class = "col">
			<p>This is footage from a club match in England. The team in blue, Manchester City, enjoys most of the ball possession. You can see their aggressive defending style around the 40-second mark. They arrange their team differently than the first clip: 4 defenders at the back, and then a mixture of midfielders and forwards that lead their attacks on goal.</p>
			<div class="embed-responsive embed-responsive-16by9">
				<iframe embed-responsive-item src="https://www.youtube.com/embed/FONVyowNjUo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			</div>
		</div>
		<div class="row">
			<p>It's common to classify the way that teams arrange their players into a <i>lineup</i>. These clips show different strategies, with Manchester City adopting something like a "4-5-1" and Hoffenheim adopting a "3-5-2." To interpret these labels, you read from left to right with the left most number representing the number of defenders. For instance, Manchester City used <b>4</b> defenders, <b>5</b> midfielders, and <b>1</b> forward.</p> 
			<p>The choice of lineup is quite important because it implicates which players will be selected; you cannot have a team with 11 defenders running around. For national teams like England, the problem is magnified because every player is phenomenal. So, before exploring the strengths of our key players, we want to consider the best lineup choice for England.</p>
		</div>
	</div>
	<div class="container" id = "title-frame-for-d3">
		<div class = "row">
			<h3>Tactics</h3>
		</div>
		<div class = "row">
			<h5>What's England's best strategy?</h5>
		</div>
	</div>
	<div class="container" id = "frame-the-d3-container">
		<div class = "row">
			<p>Recently, England have been strong performers in international tournaments, finishing in 3rd place in the 2018 World Cup and losing in the finals of the 2020 Euro Cup.</p>
			<p>Let's compare the players England selected for the 2020 Euro Cup Final against Italy to the lineup that our group thinks would give them the best chance of winning!</p>
			<p>Click between formations to see how think they should play.</p>
			<p>We've highlighted the positions of our 3 key players.</p>
		</div>
	</div>
	<div class="container" id = "image-container">
		<div class="row">
			<div class="col-lg-6">
				<h5 style = "color:#EA1F29">3-4-2-1</h5>
				<p>England's usual lineup.</p>
				<input type="image" src="https://raw.githubusercontent.com/timschott/footy-viz/main/extra/3-4-2-1.png" style="opacity: 0.6;" onclick="default_lineup()"  onmouseout="this.style.opacity=0.6;" onmouseover="this.style.opacity=1;" class="img-fluid">
			</div>
			<div class="col-lg-6">
				<h5 style = "color:#2B57AC">4-2-3-1</h5>
				<p>How England <i>should</i> play.</p>
				<input type="image" src="https://raw.githubusercontent.com/timschott/footy-viz/main/extra/4-2-3-1.png" style="opacity: 0.6;" onclick="new_lineup()"  onmouseout="this.style.opacity=0.6;" onmouseover="this.style.opacity=1;" class="img-fluid">
			</div>
		</div>	
	</div>
	<div class="container" id="positions-board-title">
		<h5><span id="tactics-title">3-4-2-1</span></h5>
		<p id="tactics-explainer">England's usual formation, which lost them the Euro 2020 Finals match. England scored a goal 2 minutes after kickoff, but managed just 1 shot on target the rest of the match. Trent-Alexander Arnold did not play, while <span id ='red-span'>Mason Mount</span> and <span id ='red-span'>Harry Kane</span> (highlighted in <span id ='red-span'>red</span>) performed poorly. This formation is relatively conservative, especially given the players England used. They fielded a team with 5 defenders instead of the usual 4. Their outside defenders (Shaw and Trippier) were tasked with shutting down wide options for Italy. This left England with scant attacking options.</p>
	</div>
	<div class="d-flex justify-content-center" id="positions-board">
	</div><br>
	<br>
	<div class="container" id="tactics-outtro">
		<div class = "row">
			<p>Now that we've established the structure of soccer teams in general and recommended a starting lineup for England, let's have a look at our key players and why we believe their presence is a critical factor for England's success.</p>
		</div>
	</div><br>
	<br>
	<div class="container" id = "title-frame-for-kane">
		<div class = "row">
			<h3>Harry Kane (Striker/Attacker)</h3>
		</div>
		<div class = "row">
			<h5>Just how good is England's star striker?</h5>
		</div>
	</div>
	<div class="container" id="frame-for-kane">
		<div class = "row">
			<p>Harry Kane boasts an impressive career for both club and country. At just 28 years of age he has already climbed England's goal-scoring ranks, boasting the third most goals in history for their national team.</p>
			<p>His playing style can be described as the perfect mixture of pragmatism and athleticism. His large frame lets him excel in aerial duels, yet his excellent footwork and great passing ability allows him to easily incorporate his teammates into attacking plays. He is far and away England's most important player. </p>
			<p>Let's take a look at Kane's international goal scoring.</p>
		</div>
	</div><br>
	<br>
	<div class="d-flex justify-content-center" id="goal-numbers-container">
	</div><br>
	<br>
	<div class="container" id="graph-outtro">
		<div class = "row">
			<p>Kane has scored more goals than any player in the world over the past 2 major competitions. He is well on his way to breaking England's all-time scoring record as well. For some in-depth analysis, let's take a look at where on the field he most effectively shoots from.</p>
		</div>
	</div><br>
	<br>
	<div class="d-flex justify-content-center" id="shot-graph-area">
		<img src="extra/shots-graph-2.png" alt="Harry Kane shot graph" class="img-fluid">
	</div><br>
	<br>
	<div class="container" id = "title-frame-for-kane">
		<div class = "row">
			<h3>Mason Mount (Midfielder)</h3>
		</div>
		<div class = "row">
			<h5>What does Mason Mount bring to the table?</h5>
		</div>
	</div>
	<div class="container" id="mount-intro">
		<div class="row">
			<p>Mason Mount is a young attacking midfielder who has been impressive in the club tournaments for Chelsea and made quite an impact in the Euro 2018 and World 2020. As a midfielder, he is responsible for attacking as well getting back on defense and helping his team win the ball back.</p>
			<p>Considering this, his performance in these two international tournaments was brilliant.</p>
			<p>Lets explore he touches the ball and where he passes the ball -- two important components of a midfielder's job description.</p>
		</div>
	</div>
	<div class="container" id = "mount-touch-intro">
		<div class="row">
			<h5>Where does Mount touch the ball?</h5>
		</div>
	<br><br>
	</div>
	<div class="d-flex justify-content-center" id="mount-touch-area">
		<center><img src="extra/mount-touches.png" width="850" height="550" alt="Mount Touches image" class="img-fluid"></center>
	</div>
	<br><br>
	<div class="row">
		<p>Mount touched the ball in all parts of the field, mostly past the halfway line. Mount is especially proactive in the <i>attacking third</i>, the third of the field closest to the oppositions goal. He had the most number of touches on the wide areas to the right and left of the goal (255 and 321 respectively).</p> 
		<p>What makes him effective from these positions is that he can then play in passes for strikers like Harry Kane to score goals.</p>
	</div>
	<br><br>
	<div class="container" id = "mount-pass-intro">
		<div class="row">
			<h5>Where does Mount pass the ball?</h5>
		</div>
	</div>
	<div class="d-flex justify-content-center" id="mount-pass-area">
		<img src="extra/mount-passes.png" alt="Mount Passes image" class="img-fluid">
	</div><br>
	<div class="row">
		<p>This graphic visualizes the position of the ball and the direction of the pass. All of these passes have end positions in the attacking third. The cluster in the wing positions illustrate how much he likes to create plays in those positions and then eventually slide in passes in the centre.</p>
		<p>Going forward, England would do well to utilize his creativity by continuing to entrust him with the responsibility of creating scoring chances for strikers like Kane. Plus, as he continues to develop and gain experience, he'll also improve as a shooter and start to score goals of his own.</p>
	</div>
	
<div class="container" id = "title-frame-for-kane">
		<div class = "row">
			<h3>Trent Alexander Arnold (Defender)</h3>
		</div>
		<div class = "row">
			<h5>What does Trent bring to the table?</h5>
		</div>
	</div>
	<div class="container" id="mount-intro">
		<div class="row">
			<p>Trent is an up and coming defender who has consistently been performing very well in the local leagues but hasnt played alot in the international games. We feel he can make a big difference in helping Mount and Kane in winning games.</p>
		</div>
	</div>
	<p>But before we begin, let us look at some ideal attacking and defensive radar charts so we can get a good baseline understanding of different playstyles.</p>
	<div class="d-flex justify-content-center" id="mount-pass-area">
		<img src="extra/together_base_final.png" alt="together radar image" class="img-fluid">
	</div>
	<p>Let us now contrast these shapes to how Trent compares to other talented defenders currently in Englands International team such as Kyle Walker.</p>
	<div class="d-flex justify-content-center" id="mount-touch-area">
		<img src="extra/trent_radar.png" alt="Trent Passing image" class="img-fluid">
	</div>
	<div class="row">
		<p> By reflecting Trent and Kyles playstyle to the ideal attacking and defensive charts above you can see how Trent is more suited towards an attacking playstyle as compared to Kyle who is more defensive.</p>
	</div>
	<div class="row">
		<p> This data lays a strong argument that Trent's attacking playstyle will link very well with Mount and Kane to make England an aggressive goal scoring machine. We argue that such a combination can become a world cup winning strategy given how well all three players are currently performing. </p>
	</div>
	<div class="container" id = "title-frame-for-kane">
		<div class = "row">
			<h3>Summary</h3>
		</div>
	</div>
	<div class="row">
		<p> We think and the data supports that these three players playing key roles in attack, midfield and defence can make the difference that can help England bring the cup home this year. If you would like to learn more about the data we have used please refer to <a href="https://statsbomb.com/what-we-do/soccer-data/">StatsbombR</a> and <a href ="https://fbref.com/en/">fbref.com</a> which have albeit less data on international matches, has great information on soccer as a whole.</p>
	</div>
<footer class="site-footer">
	<span class="site-footer-owner"><a href="https://github.com/timschott/footy-viz">footy-viz</a> is maintained by <a href="https://github.com/timschott">timschott</a>.</span>
	<span class="site-footer-credits">This page was generated by <a href="https://pages.github.com">GitHub Pages</a>.</span>
</footer>
</body>
