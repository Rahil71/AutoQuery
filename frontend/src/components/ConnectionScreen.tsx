import React, { useState } from 'react';
import { motion } from 'framer-motion';

interface Props {
  onConnect: (url: string) => Promise<void>;
  loading: boolean;
}

export default function ConnectionScreen({ onConnect, loading }: Props) {
  const [dbUrl, setDbUrl] = useState('');

  return (
    <div className="min-h-screen bg-slate-950 flex items-center justify-center p-6">
      <motion.div 
        initial={{ opacity: 0, scale: 0.95, y: 20 }} 
        animate={{ opacity: 1, scale: 1, y: 0 }}
        className="max-w-md w-full bg-slate-900 border border-slate-800 p-8 rounded-3xl shadow-2xl relative overflow-hidden group"
      >
        {/* Playful background glow interaction */}
        <div className="absolute -top-20 -right-20 w-40 h-40 bg-indigo-500/20 rounded-full blur-3xl group-hover:bg-indigo-500/30 transition-colors duration-700"></div>
        
        {/* LOGO REPLACEMENT */}
        <div className="flex justify-center mb-6 relative z-10">
          <motion.div 
            initial={{ rotate: -15, opacity: 0 }}
            animate={{ rotate: 0, opacity: 1 }}
            transition={{ delay: 0.2, type: 'spring' }}
            className="p-4 bg-indigo-500/10 rounded-2xl border border-indigo-500/20 shadow-lg"
          >
            {/* Logo Image */}
            <img src="/logo.jpeg" alt="AutoQuery AI Logo" className="w-16 h-16 object-contain" />
          </motion.div>
        </div>
        
        <h1 className="text-3xl font-bold text-white text-center mb-2 relative z-10 tracking-tighter">AutoQuery AI</h1>
        <p className="text-slate-400 text-center mb-8 relative z-10 leading-relaxed">Connect your database to initialize the isolated sandbox.</p>
        
        <input 
          className="w-full bg-slate-950 border border-slate-700 rounded-xl p-3 text-white mb-4 focus:ring-2 focus:ring-indigo-500 outline-none transition-all relative z-10 custom-scrollbar"
          placeholder="postgresql://user:pass@host:port/db"
          value={dbUrl}
          onChange={(e) => setDbUrl(e.target.value)}
        />
        
        <motion.button 
          whileHover={{ scale: 1.02, y: -2 }}
          whileTap={{ scale: 0.98 }}
          onClick={() => onConnect(dbUrl)}
          disabled={loading || !dbUrl}
          className="w-full bg-indigo-600 hover:bg-indigo-500 text-white font-semibold py-3 rounded-xl transition-all disabled:opacity-50 relative z-10 shadow-lg"
        >
          {loading ? "Initializing Sandbox..." : "Connect Database"}
        </motion.button>
      </motion.div>
    </div>
  );
}