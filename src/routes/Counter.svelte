<script lang="ts">
	import { spring } from 'svelte/motion';

	let count = 0;

	const displayed_count = spring();
	$: displayed_count.set(count);
	$: offset = modulo($displayed_count, 1);

	function modulo(n: number, m: number) {
		// handle negative numbers
		return ((n % m) + m) % m;
	}
</script>

<div class="counter">
	<button on:click={() => (count -= 1)}>
		<svg viewBox="0 0 1 1">
			<path d="M0,0.5 L1,0.5" />
		</svg>
	</button>

	<div>
		<div class="counter-digits" style="transform: translate(0, {100 * offset}%)">
			<strong>{Math.floor($displayed_count)}</strong>
		</div>
	</div>

	<button on:click={() => (count += 1)}>
		<svg viewBox="0 0 1 1">
			<path d="M0,0.5 L1,0.5 M0.5,0 L0.5,1" />
		</svg>
	</button>
</div>

<style lang="scss">
    .counter {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 200px;
        font-size: 64px;
        font-family: monospace;
        font-weight: 100;
        color: #fff;
        background: #444;
    }

    button {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100%;
        width: 100%;
        border: none;
        // background: transparent;
        cursor: pointer;
        outline: 3px , solid , transparent;
    }

    .counter-digits {
        display: flex;
        flex-direction: column;
        height: 100%;
        width: 100%;
        transition: transform 0.5s cubic-bezier(0.23, 1, 0.32, 1);
    }
</style>
