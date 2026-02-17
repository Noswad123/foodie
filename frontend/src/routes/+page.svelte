<script lang="ts">
  import { onMount } from 'svelte';

  let status = 'checking...';
  let error: string | null = null;

  async function check() {
    status = 'checking...';
    error = null;

    try {
      const res = await fetch('http://127.0.0.1:8080/healthz');

      if (!res.ok) {
        const text = await res.text();
        throw new Error(text || `HTTP ${res.status}`);
      }

      status = await res.text();
    } catch {
      error =
        'Backend not running on port 8080.\n\nStart it with:\n\n  go run ./cmd/server';
      status = 'down';
    }
  }

  onMount(() => {
    check();
  });
</script>

<h1>Foodie</h1>

<p>Backend health: <strong>{status}</strong></p>

{#if error}
  <pre style="color: red; white-space: pre-wrap">{error}</pre>
{/if}

<button on:click={check}>Re-check</button>
