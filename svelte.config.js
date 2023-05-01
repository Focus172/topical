import adapter from '@sveltejs/adapter-static';
// import { vitePreprocess } from '@sveltejs/kit/vite';
import preprocess from 'svelte-preprocess';

const config = {
	// Consult https://kit.svelte.dev/docs/integrations#preprocessors
	// for more information about preprocessors
    kit: {
		// adapter-auto only supports some environments, see https://kit.svelte.dev/docs/adapter-auto for a list.
		// If your environment is not supported or you settled on a specific environment, switch out the adapter.
		// See https://kit.svelte.dev/docs/adapters for more information about adapters.
		// adapter: adapter()

        adapter: adapter({
            pages: 'public',
            assets: 'public',
            // fallback: 'index.html',
            precompress: false
        })
        // prerender: {
        //     default: true
        // }
	},
	// preprocess: vitePreprocess(),
    preprocess: [
        preprocess({
            sass: true
        })
    ]
};

export default config;
