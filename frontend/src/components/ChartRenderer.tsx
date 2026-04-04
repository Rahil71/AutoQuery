import { Bar, Line, Pie } from 'react-chartjs-2';
import { Chart as ChartJS, registerables } from 'chart.js';
import type { ChartConfig } from '../types';

ChartJS.register(...registerables);

export default function ChartRenderer({ config }: { config: ChartConfig }) {
  const components = { bar: Bar, line: Line, pie: Pie };
  const SelectedChart = components[config.chart_type] || Bar;

  const chartData = {
    labels: config.labels,
    datasets: config.datasets.map((ds) => ({
      ...ds,
      backgroundColor: config.chart_type === 'pie' 
        ? ['#6366f1', '#8b5cf6', '#ec4899', '#14b8a6', '#f59e0b']
        : 'rgba(99, 102, 241, 0.6)',
      borderColor: '#4f46e5',
      borderWidth: 1,
    }))
  };

  const options = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: { labels: { color: '#cbd5e1' } },
      title: { display: true, text: config.title, color: '#f8fafc' }
    },
    scales: config.chart_type !== 'pie' ? {
      y: { grid: { color: '#334155' }, ticks: { color: '#94a3b8' } },
      x: { grid: { color: '#334155' }, ticks: { color: '#94a3b8' } }
    } : undefined
  };

  return (
    <div className="h-64 mt-6">
      <SelectedChart data={chartData} options={options} />
    </div>
  );
}