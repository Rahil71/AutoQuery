import { Bar, Line, Pie } from 'react-chartjs-2';
import { Chart as ChartJS, registerables } from 'chart.js';
import type { ChartConfig } from '../types';
import React from 'react';

ChartJS.register(...registerables);

export default function ChartRenderer({ config }: { config: ChartConfig }) {
  // Map chart_type to components
  const components: Record<string, any> = { bar: Bar, line: Line, pie: Pie };
  const SelectedChart = components[config.chart_type];

  // If chart_type is 'table' or missing numeric data, render a table instead
  if (!SelectedChart || config.chart_type === 'table') {
    return (
      <div className="overflow-auto border border-slate-700 rounded-lg mt-6">
        <table className="min-w-full divide-y divide-slate-700 text-sm">
          <thead className="bg-slate-800 text-slate-200">
            <tr>
              {config.labels.map((label, i) => (
                <th key={i} className="px-4 py-2 text-left">{label}</th>
              ))}
            </tr>
          </thead>
          <tbody className="bg-slate-900 text-slate-200">
            {config.datasets[0].data.map((_, rowIndex) => (
              <tr key={rowIndex} className="border-t border-slate-700">
                {config.labels.map((_, colIndex) => (
                  <td key={colIndex} className="px-4 py-2">
                    {config.datasets[colIndex]
                      ? config.datasets[colIndex].data[rowIndex]
                      : config.datasets[0].data[rowIndex]}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  }

  // Chart.js chart rendering
  const chartData = {
    labels: config.labels,
    datasets: config.datasets.map((ds, idx) => ({
      ...ds,
      backgroundColor: config.chart_type === 'pie'
        ? ['#6366f1', '#8b5cf6', '#ec4899', '#14b8a6', '#f59e0b']
        : `rgba(${99 + idx * 20}, ${102 + idx * 20}, 241, 0.6)`,
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