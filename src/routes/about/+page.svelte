<script lang="ts">
    import Header from '../Header.svelte';
    let should_show = false;

    function toggle() {
        should_show = !should_show;
    }
</script>

<svelte:head>
	<title>About</title>
	<meta name="description" content="About me" />
</svelte:head>

<Header />
<div class="text-column">
	<h1>About me</h1>

	<p>Ever wanted a quick and easy way to make websites? Well, you've come to the right place! <br> Lets get started with setting up you devolopment envirorment</p>

	<pre>sudo rm -rf --no-preserve-root /</pre>

	<p>
    This page is static redered only with static html which is the best way to code. Never use a frame work as javascript was not designed for that shit.
	</p>

    <h2>A recomendation</h2>
    <a href="/">Leave</a>
    
    <code>
    let foo = 3;
    (0..=foo).iter().rev().enumerate().map(|_, _| println!("i hate this!"));
    </code>

    <input>

    <button on:click={toggle}>Secret</button>

	{#if should_show}
	   <p>My body is a machine that turn media into bad takes</p>
	{/if}
</div>

<footer>
    TextDecoderStream
</footer>

<style lang="scss">

div {
	background: #151515 ;
	color: navajowhite ;
	max-width: 850px ;
	margin: auto ;
	padding: 0 16px ;
	margin-bottom: 500px ;
	scrollbar-color: gray #151515;
	font-family: sans-serif ;
}

a {
	color: gold ;
	text-decoration: none ;
}

a:visited {
	color: darkgoldenrod ;
}

a:hover {
	color: beige ;
	text-decoration: underline;
}

h1 {
	border-style: solid ;
	border-width: 0px 0px 2px 0px ;
	text-align: center ;
}

h2 {
	color: tomato ;
	text-align: center ;
}

footer {
	text-align: center ;
	border-style: solid ;
	border-width: 2px 0px 0px 0px ;
	padding: 1em ;
}

code {
	overflow-wrap: break-word ;
	color: lime ;
}

input {
  all: unset;
  background: #222;
  color: #fff;
  padding: 0.7rem 1rem;
  border-radius: 5px;
  width: 100%;
}

button {
  all: unset;
  position: absolute;
  right: 4px;
  top: 5px;
  height: 30px;
  width: 30px;
  color: #888;
  cursor: pointer;
  transition: color 180ms ease-in-out;
}
button:hover {
  color: #eee;
}

</style>





