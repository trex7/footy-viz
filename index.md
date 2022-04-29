<script src="js/test.js"></script>
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
			<p>Can they win this year's World Cup?</p>
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
			<h3>Primer</h3>
		</div>
		<div class = "row">
			<h5>How are soccer teams structured?</h5>
		</div>
	</div>
	<div class="container" id = "frame-the-primer">
		<div class = "row">
			<p>Each team has 11 players. There are two 45 minute halves. The purpose of the game is to score goals against the opposition. Whoever has the most goals at the end of the game wins. It's illegal to use your hands, of course -- which is why most other countries refer to the game as "football."</p>
			<p>Besides the goalkeeper, players fall into 3 broad categories. <i>Forwards</i> are the goal scorers who are the best at shooting and scoring goals. <i>Defenders</i> protect their goal and try to stop opposition forwards from advancing. <i>Midfielders</i> occupy the middle of the field and try to link together the work from their team's defense and make opportunities for the forwards to score.</p>
			<p>Each country organizes its soccer teams into a system of "leagues" similar to the NFL. For example, in England their top soccer league is the "Premier League" and in Germany it is the "Bundesliga." Within those leagues, the teams are typically referred to as <i>clubs</i>.</p>
			<p>The best players from across the world receive the honor to play for their country of origin's <i>national team</i>. The dynamics of each national team are fascinating, then, because players whose "day-jobs" are quite different from one another have to coalesce in short stints of "international breaks" throughout the club soccer season.</p>
			<p>Winning the World Cup is the crown jewel for national teams. It's played every 4 years, and is the most-watched and most-prestigious sporting event in the world</p>.
			<p>To get a better sense of what a soccer team looks lke in action, we're going to introduce a few videos and screencaps from matches.</p>
		</div>
	</div>
	<div class="container" id = "title-frame-for-primer">
		<div class = "row">
			<h3>Match Footage</h3>
		</div>
		<div class = "row">
			<h5>How are soccer teams structured?</h5>
		</div>
		<div class = "embed-responsive embed-responsive-16by9">
			<iframe embed-responsive-item src="https://www.youtube.com/embed/FONVyowNjUo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
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
		<p id="tactics-explainer">England's usual formation, which lost them the Euro 2020 Finals match. England scored a goal 2 minutes after kickoff, but managed just 1 shot on target the rest of the match. Trent-Alexander Arnold did not play, while <span id ='red-span'>Mason Mount</span> and <span id ='red-span'>Harry Kane</span> (highlighted in <span id ='red-span'>red</span>) performed poorly. This formation is relatively conservative, especially given the players England used. They fielded a team with 5 defenders instead of the usual 4. Their outside defenders (Shaw and Trippier) were tasked with shutting down wide options for Italy. This left England with scant attacking options when they received the ball.</p>
	</div>
	<div class="container" id="positions-board">
	</div>
<footer class="site-footer">
	<span class="site-footer-owner"><a href="https://github.com/timschott/footy-viz">footy-viz</a> is maintained by <a href="https://github.com/timschott">timschott</a>.</span>
	<span class="site-footer-credits">This page was generated by <a href="https://pages.github.com">GitHub Pages</a>.</span>
</footer>
</body>