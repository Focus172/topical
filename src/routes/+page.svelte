<script lang="ts">
    import Header from "./Header.svelte";
    // import style from "./style.css";

    let input: string = "test";
    // $: {
    //     if (test.length % 2 === 0) {
    //         console.log("even");
    //     } else {
    //         console.log("odd");
    //     }
    // }

    const letters: string[] = "abcdefghijklmnopqrstuvwxyz".split("");

    $: rand = input
        .split("")
        .map((_) => {
            letters[Math.floor(Math.random() * 26)];
        })
        .join("");
</script>

<svelte:head>
    <title>Home</title>
    <meta name="description" content="Demo Site" />
</svelte:head>

<div class="app">
    <Header />

    <h1>Welcome</h1>

    <h1>to whatever this<br />hell is</h1>

    <input type="text" bind:value={input} />

    <h3>{rand}</h3>

    <button on:click={() => (input = "test")}>reset</button>

    <div class="main">
        <h2>
            try leaving for now, <strong>the problem wont get better</strong>
        </h2>
    </div>

    <div id="message">
        <h2>Welcome</h2>
        <h1>Test</h1>
        <p>more text</p>
    </div>

    <footer>
        <p>Made using <a href="https://kit.svelte.dev">Svelte Kit</a>.</p>
    </footer>
</div>

<!-- <meta charset="utf-8"> -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
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
