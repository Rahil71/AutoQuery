import { Bar, Line, Pie } from 'react-chartjs-2';
import { Chart as ChartJS, registerables } from 'chart.js';
import type { ChartConfig } from '../types';
import React from 'react';

ChartJS.register(...registerables);

export default function ChartRenderer({ config }: { config: ChartConfig | null }) {
  const components: Record<string, any> = {
    bar: Bar,
    line: Line,
    pie: Pie
  };

  // ✅ SAFETY CHECK (prevents crash when config is string/null/invalid)
  if (!config || typeof config !== 'object') {
    return (
      <div className="text-sm text-slate-500 mt-6">
        No visualization available
      </div>
    );
  }

  const SelectedChart = components[config.chart_type];

  // 🟢 TABLE RENDERING (fallback or explicit table)
  if (!SelectedChart || config.chart_type === 'table') {
    const rows = config.datasets?.[0]?.data || [];
    const labels = config.labels || [];

    return (
      <div className="overflow-auto border border-slate-700 rounded-lg mt-6">
        <table className="min-w-full divide-y divide-slate-700 text-sm">
          
          {/* HEADER */}
          <thead className="bg-slate-800 text-slate-200">
            <tr>
              {labels.length > 0 ? (
                labels.map((label, i) => (
                  <th key={i} className="px-4 py-2 text-left">
                    {label}
                  </th>
                ))
              ) : (
                <th className="px-4 py-2 text-left">Data</th>
              )}
            </tr>
          </thead>

          {/* BODY */}
          <tbody className="bg-slate-900 text-slate-200">
            {rows.length === 0 ? (
              <tr>
                <td
                  colSpan={labels.length || 1}
                  className="px-4 py-2 text-center text-slate-400"
                >
                  No data available
                </td>
              </tr>
            ) : (
              rows.map((row: any, rowIndex: number) => (
                <tr key={rowIndex} className="border-t border-slate-700">
                  {(labels.length > 0 ? labels : Object.keys(row)).map(
                    (label, colIndex) => (
                      <td key={colIndex} className="px-4 py-2">
                        {row?.[label] ?? '-'}
                      </td>
                    )
                  )}
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    );
  }

  // 🔵 CHART RENDERING (numeric charts)
  const chartData = {
    labels: config.labels || [],
    datasets: (config.datasets || []).map((ds, idx) => ({
      ...ds,
      backgroundColor:
        config.chart_type === 'pie'
          ? ['#6366f1', '#8b5cf6', '#ec4899', '#14b8a6', '#f59e0b']
          : `rgba(${99 + idx * 20}, ${102 + idx * 20}, 241, 0.6)`,
      borderColor: '#4f46e5',
      borderWidth: 1
    }))
  };

  const options: any = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        labels: { color: '#cbd5e1' }
      },
      title: {
        display: !!config.title,
        text: config.title,
        color: '#f8fafc'
      }
    },
    scales:
      config.chart_type !== 'pie'
        ? {
            y: {
              grid: { color: '#334155' },
              ticks: { color: '#94a3b8' }
            },
            x: {
              grid: { color: '#334155' },
              ticks: { color: '#94a3b8' }
            }
          }
        : undefined
  };

  return (
    <div className="h-64 mt-6">
      <SelectedChart data={chartData} options={options} />
    </div>
  );
}