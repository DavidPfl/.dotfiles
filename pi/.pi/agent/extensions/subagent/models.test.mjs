import { test } from 'node:test';
import { strict as assert } from 'node:assert';
import { parseModelList, resolveAgentModel } from './models.ts';

const available = [
  { provider: 'deepseek', id: 'deepseek-v4-pro' },
  { provider: 'opencode-go', id: 'glm-5.3-flash' },
  { provider: 'openai', id: 'shared' },
  { provider: 'other', id: 'shared' },
];

test('parses single strings, comma-separated strings, and YAML arrays', () => {
  assert.deepEqual(parseModelList('deepseek-v4-pro'), ['deepseek-v4-pro']);
  assert.deepEqual(parseModelList(' missing, opencode-go/glm-5.3-flash , deepseek-v4-pro '),
    ['missing', 'opencode-go/glm-5.3-flash', 'deepseek-v4-pro']);
  assert.deepEqual(parseModelList(['missing', ' deepseek-v4-pro ', null, '']), ['missing', 'deepseek-v4-pro']);
  assert.equal(parseModelList({ model: 'wrong' }), undefined);
});

test('selects first available preference in order', () => {
  assert.equal(resolveAgentModel(['missing', 'opencode-go/glm-5.3-flash', 'deepseek-v4-pro'], available),
    'opencode-go/glm-5.3-flash');
  assert.equal(resolveAgentModel(['deepseek-v4-pro', 'opencode-go/glm-5.3-flash'], available),
    'deepseek/deepseek-v4-pro');
  assert.equal(resolveAgentModel(['MISSING', 'DEEPSEEK-V4-PRO'], available), 'deepseek/deepseek-v4-pro');
});

test('skips ambiguous bare IDs and does not silently choose a different model', () => {
  assert.equal(resolveAgentModel(['shared', 'other/shared'], available), 'other/shared');
  assert.equal(resolveAgentModel(['shared', 'missing'], available), undefined);
  assert.equal(resolveAgentModel(['missing'], available), undefined);
  assert.equal(resolveAgentModel(['deepseek-v4-pro'], []), undefined);
});
