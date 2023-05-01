<script lang="ts">
    import Header from "./Header.svelte";

    let test = "test";
    $: {
        if ( test.length % 2 === 0 ) {
            console.log( "even" );
        } else {
            console.log( "odd" );
        }
    }
</script>

<svelte:head>
    <title>Home</title>
    <meta name="description" content="Demo Site" />
</svelte:head>

<div class="app">
    <Header />

    <h1>Welcome</h1>

    <h1>to whatever this<br />hell is</h1>

    <input type="text" bind:value={test} />

    <h3>{test}</h3>

    <button on:click={() => test = "test"}>reset</button>

    <div class="main">
        <h2>
            try leaving for now, <strong>the problem wont get better</strong>
        </h2>
    </div>

    <footer>
        <p>Made using <a href="https://kit.svelte.dev">Svelte Kit</a>.</p>
    </footer>
</div>

<style lang="scss">
    .app {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    footer {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 12px;
    }

    footer a {
        font-weight: bold;
    }

    @media (min-width: 480px) {
        footer {
            padding: 12px 0;
        }
    }

    h1 {
        width: 100%;
    }

    :root {
        --font-body: Arial, -apple-system, BlinkMacSystemFont, "Segoe UI",
            Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue",
            sans-serif;
        --font-mono: "Fira Mono", monospace;
        --color-bg-0: rgb(202, 216, 228);
        --color-bg-1: hsl(209, 36%, 86%);
        --color-bg-2: hsl(224, 44%, 95%);
        --color-theme-1: #ff3e00;
        --color-theme-2: #4075a6;
        --color-text: rgba(0, 0, 0, 0.7);
        --column-width: 42rem;
        --column-margin-top: 4rem;
        font-family: var(--font-body);
        color: var(--color-text);
    }

    h1,
    h2,
    p {
        font-weight: 400;
    }

    p {
        line-height: 1.5;
    }

    a {
        color: var(--color-theme-1);
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    h1 {
        font-size: 2rem;
        text-align: center;
    }

    h2 {
        font-size: 1rem;
    }

    @media (min-width: 720px) {
        h1 {
            font-size: 2.4rem;
        }
    }
</style>
    <!-- <meta charset="utf-8"> -->
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
  

    <h1>Projects</h1>
    <div class="project-list">
      <div class="project">
        <h2>Project 1</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        <a href="https://example.com/project1" target="_blank"><img src="https://via.placeholder.com/400x300" alt="Project 1" /></a>
      </div>
      <div class="project">
        <h2>Project 2</h2>
        <p>Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        <a href="https://example.com/project2" target="_blank"><img src="https://via.placeholder.com/400x300" alt="Project 2" /></a>
      </div>
    </div>
    <div id="message">
      <h2>Welcome</h2>
      <h1>Test</h1>
      <p>more text</p>
    </div>

