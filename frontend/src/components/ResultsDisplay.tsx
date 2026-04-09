import React, { useState } from 'react';
import axios from 'axios';
import { ShieldCheck, Info, FileText, Download } from 'lucide-react';
import { motion } from 'framer-motion';
import ChartRenderer from './ChartRenderer';
import type { QueryResponse } from '../types';

const API_BASE = "http://localhost:5001/api";

interface Props {
  result: QueryResponse;
  query: string;
  provider: string;
}

export default function ResultsDisplay({ result, query, provider }: Props) {
  const [isDownloading, setIsDownloading] = useState(false);

  const handleDownloadReport = async () => {
    setIsDownloading(true);
    try {
      // We use responseType: 'blob' to handle binary PDF data
      const response = await axios.post(`${API_BASE}/report`, {
        query,
        provider
      }, {
        responseType: 'blob' 
      });

      // Create a temporary URL to trigger the browser's download prompt
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', `AutoQuery_Report_${Date.now()}.pdf`);
      document.body.appendChild(link);
      link.click();
      link.parentNode?.removeChild(link);
    } catch (err) {
      console.error("Failed to download report", err);
      alert("Failed to generate PDF report. Check your backend logs.");
    } finally {
      setIsDownloading(false);
    }
  };

  return (
    <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} className="space-y-6">
      
      {/* SQL & Explanation Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div className="bg-slate-900 p-4 rounded-xl border border-slate-800 flex flex-col gap-3 shadow-sm">
          <div>
            <p className="text-[10px] font-mono text-slate-500 mb-1 uppercase">Generated SQL</p>
            <code className="text-slate-400 text-xs block overflow-x-auto custom-scrollbar pb-2">{result.original_sql}</code>
          </div>
          {result.optimized_sql && (
            <div className="pt-2 border-t border-slate-800">
               <p className="text-[10px] font-mono text-emerald-500 mb-1 uppercase flex items-center gap-1">
                 <ShieldCheck className="w-3 h-3" /> Optimized & Sandboxed
               </p>
               <code className="text-emerald-300 text-xs block overflow-x-auto custom-scrollbar">{result.optimized_sql}</code>
            </div>
          )}
        </div>

        {result.explanation && (
          <div className="bg-indigo-500/5 p-4 rounded-xl border border-indigo-500/10 shadow-sm">
            <p className="text-xs font-bold text-indigo-400 mb-2 flex items-center gap-1 uppercase">
              <Info className="w-4 h-4" /> AI Explanation
            </p>
            <p className="text-sm text-slate-300 leading-relaxed">"{result.explanation}"</p>
          </div>
        )}
      </div>

      {/* Chart Visualization */}
      {result.chart && (
        <div className="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-sm">
           <ChartRenderer config={result.chart} />
        </div>
      )}

      {/* Data Table & PDF Download */}
      <div className="bg-slate-900 border border-slate-800 rounded-2xl overflow-hidden shadow-lg relative">
        <div className="p-4 border-b border-slate-800 flex flex-wrap items-center justify-between bg-slate-900/50 gap-4">
          <h3 className="font-semibold text-slate-200 tracking-tight flex items-center gap-2">
             Query Results <span className="bg-slate-800 text-slate-400 px-2 py-0.5 rounded-md text-xs">{result.data.length} rows</span>
          </h3>
          
          {/* PDF Download Button */}
          <motion.button
            whileHover={{ scale: 1.02 }}
            whileTap={{ scale: 0.98 }}
            onClick={handleDownloadReport}
            disabled={isDownloading}
            className="flex items-center gap-2 text-xs bg-indigo-500/10 text-indigo-400 border border-indigo-500/20 px-3 py-1.5 rounded-lg hover:bg-indigo-500/20 transition-all font-medium disabled:opacity-50"
          >
            {isDownloading ? (
               <Download className="w-3.5 h-3.5 animate-bounce" />
            ) : (
               <FileText className="w-3.5 h-3.5" />
            )}
            {isDownloading ? "Generating PDF..." : "Download PDF Report"}
          </motion.button>
        </div>

        <div className="overflow-x-auto max-h-[400px] custom-scrollbar">
          <table className="w-full text-left text-sm relative">
            <thead className="bg-slate-950 text-slate-400 uppercase text-[10px] sticky top-0 z-10 shadow-sm">
              <tr>
                {result.data.length > 0 && Object.keys(result.data[0]).map(key => (
                  <th key={key} className="px-6 py-3 font-medium whitespace-nowrap">{key}</th>
                ))}
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800/50">
              {result.data.map((row, i) => (
                <tr key={i} className="hover:bg-slate-800/30 transition-colors">
                  {Object.values(row).map((val: string | number | boolean | null, j) => (
                    <td key={j} className="px-6 py-4 text-slate-300 whitespace-nowrap">
                      {val === null ? <span className="text-slate-600 italic">null</span> : val.toString()}
                    </td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </motion.div>
  );
}