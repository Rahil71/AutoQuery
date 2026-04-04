import React from 'react';
import { Send, RefreshCw } from 'lucide-react';
import { motion } from 'framer-motion';

interface Props {
  query: string;
  setQuery: (q: string) => void;
  handleQuery: () => void;
  loading: boolean;
}

export default function QueryInterface({ query, setQuery, handleQuery, loading }: Props) {
  return (
    <motion.section 
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.5, ease: "easeOut" }}
      className="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl relative overflow-hidden group"
    >
      {/* Subtle animated background gradient */}
      <div className="absolute inset-0 bg-gradient-to-r from-indigo-500/5 to-purple-500/5 opacity-0 group-hover:opacity-100 transition-opacity duration-700 pointer-events-none" />

      <h2 className="text-lg font-semibold mb-4 flex items-center gap-2 text-white relative z-10">
        <Send className="w-4 h-4 text-indigo-400" /> Ask your Database
      </h2>
      
      {/* Focus Ring & Shadow effect container */}
      <div className="relative z-10 group-focus-within:shadow-[0_0_30px_-5px_rgba(99,102,241,0.15)] transition-shadow duration-500 rounded-xl">
        <textarea 
          rows={3}
          className="w-full bg-slate-950 border border-slate-700 rounded-xl p-4 pr-16 text-white focus:ring-2 focus:ring-indigo-500 outline-none transition-all resize-none shadow-inner custom-scrollbar"
          placeholder="E.g., Show me the top 5 customers by total order amount..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          onKeyDown={(e) => { 
            if (e.key === 'Enter' && !e.shiftKey) { 
              e.preventDefault(); 
              handleQuery(); 
            } 
          }}
        />
        <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
          onClick={handleQuery}
          disabled={loading || !query}
          className="absolute bottom-4 right-4 bg-indigo-600 p-2.5 rounded-xl hover:bg-indigo-500 disabled:opacity-50 transition-colors shadow-lg"
        >
          {loading ? (
            <RefreshCw className="w-5 h-5 text-white animate-spin" />
          ) : (
            <Send className="w-5 h-5 text-white" />
          )}
        </motion.button>
      </div>
    </motion.section>
  );
}