/** Accept a single model, a comma-separated string, or a YAML list, in preference order. */
export function parseModelList(value: unknown): string[] | undefined {
	const raw = Array.isArray(value) ? value : typeof value === "string" ? value.split(",") : [];
	const models = raw.filter((m): m is string => typeof m === "string").map((m) => m.trim()).filter(Boolean);
	return models.length > 0 ? models : undefined;
}

/** Resolve preferences against authenticated/available models, never the full catalog. */
export function resolveAgentModel(
	preferences: string[],
	available: readonly { provider: string; id: string }[],
): string | undefined {
	for (const preference of preferences) {
		const reference = preference.toLowerCase();
		const canonical = available.filter((m) => `${m.provider}/${m.id}`.toLowerCase() === reference);
		if (canonical.length === 1) return `${canonical[0].provider}/${canonical[0].id}`;
		// Bare IDs are supported, but must identify exactly one provider.
		const bare = available.filter((m) => m.id.toLowerCase() === reference);
		if (bare.length === 1) return `${bare[0].provider}/${bare[0].id}`;
	}
	return undefined;
}
