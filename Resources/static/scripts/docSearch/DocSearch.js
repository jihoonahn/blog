import docsearch from '@docsearch/js';

import '@docsearch/css';

docsearch({
  container: '#docsearch',
  appId: 'YOUR_APP_ID',
  indexName: 'YOUR_INDEX_NAME',
  apiKey: 'YOUR_SEARCH_API_KEY',
});
