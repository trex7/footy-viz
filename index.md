<script src="js/test.js"></script>
<script src="js/formations.js"></script>
<body>
	<div class="container" id = "title-container">
		<div class="row">
			<h3>Analyzing England Soccer Superstars</h3>
		</div>
	</div>
	<div class="container" id = "intro-container">
		<div class = "row">
			<p>Although the English men's soccer team is one of the oldest national teams in the world, they’ve only won a single major tournament: the 1966 World Cup.</p>
			<p>Can they win this year's World Cup?</p>
			<p>We'll analyze their squad through a few different perspectives, focusing on 3 key players:</p>
		</div>
	</div>
	<div class="container" id = "card-container">
		<div class = "row">
			<div class="col" id ="kane-card">
				<img src="extra/kane_playing_card.png" alt="Harry Kane playing card">
			</div>
			<div class="col" id ="mount-card">
				<img src="extra/mount_playing_card.png" alt="Mason Mount playing card">
			</div>
			<div class="col" id ="trent-card">
				<img src="extra/trent_playing_card.png" alt="Trent Alexander-Arnold playing card">
			</div>
		</div>
	</div>
	<!-- >
	Example of using an event handler and linking to a external js func.
	<div class="container" id = "button-test">
		<p class="button-able">Test Text Here</p>
		<button onclick="changeColor()">Test Button Here</button>
	</div>
	-->
	<div class="mt-2 container" id = "title-frame-for-d3">
		<div class = "row">
			<h3>England's Tactics: Our Recommendation</h3>
		</div>
	</div>
	<div class="container" id = "frame-the-d3-container">
		<div class = "row">
			<p>Let's compare how they selected and arranged their team formation in the 2020 Euro Cup Final vs. Italy to the lineup that our group thinks would give them the best chance of winning!</p>
		</div>
	</div>
	<div class="container" id = "image-container">
		<div class="row">
			<div class="col">
				<h5>3-4-2-1</h5>
				<!--
				<p>This is how England at Euro 2020 Final. Starting with 3 defenders at the back can underpin an aggressively offensive strategy, but England's personnel included an equal number of defenders and attacking players. This resulted in a rather rigid gameplan that produced few promising attack chances -- save for an almost immediate goal in the second minute, courtesy of Luke Shaw.</p>
				-->	
				<input type="image" src="extra/default-tactics-board.png" style="opacity: 0.6;" onclick="default_lineup()"  onmouseout="this.style.opacity=0.6;" onmouseover="this.style.opacity=1;"/>
				<p>England's formation for the Euro 2020 Finals match...where they lost to Italy.</p>
			</div>
			<div class="col">
				<h5>4-2-3-1</h5>
				<p>How England <i>should</i> play.</p>
			</div>
		</div>	
	</div>
	<div class="container" id="positions-container">
		<div class="row" id = "positions-board">
		</div>
	</div>
</body>