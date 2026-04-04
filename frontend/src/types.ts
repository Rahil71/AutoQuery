export interface SchemaNode {
  id: string;
  label: string;
  columns: string[];
  primary_key: string[];
}

export interface SchemaEdge {
  source: string;
  target: string;
  label: string;
  from_column?: string;
  to_column?: string;
}

export interface GraphData {
  nodes: SchemaNode[];
  edges: SchemaEdge[];
}

export interface ChartConfig {
  chart_type: 'bar' | 'line' | 'pie';
  title: string;
  labels: string[];
  datasets: { label: string; data: number[] }[];
}

export interface QueryResponse {
  original_sql: string;
  optimized_sql: string | null;
  executed_sql: string;
  // This matches your visualization logic and general SQL row structure
  data: Record<string, string | number | boolean | null>[];
  explanation: string | null;
  chart: ChartConfig | null;
  provider_used: string;
}