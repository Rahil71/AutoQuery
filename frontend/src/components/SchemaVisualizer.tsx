import React, { useMemo } from 'react';
import ReactFlow, { Background, Controls } from 'reactflow';
import { motion } from 'framer-motion';
import 'reactflow/dist/style.css';
import type { Node, Edge } from 'reactflow';
import type { GraphData } from '../types';

interface Props {
  graphData: GraphData | null;
}

export default function SchemaVisualizer({ graphData }: Props) {
  const nodes: Node[] = useMemo(() => {
    if (!graphData) return [];
    return graphData.nodes.map((n, i) => ({
      id: n.id,
      position: { x: (i % 2) * 250, y: Math.floor(i / 2) * 150 },
      data: {
        label: (
          <div className="p-2 border-t-2 border-indigo-500 bg-slate-900 rounded shadow-lg text-[10px] min-w-[120px]">
            <div className="font-bold border-b border-slate-700 pb-1 mb-1 text-white">{n.label}</div>
            {n.columns.map((col) => (
              <div key={col} className={`flex justify-between ${n.primary_key.includes(col) ? "text-yellow-500 font-semibold" : "text-slate-300"}`}>
                <span>{col}</span>
                {n.primary_key.includes(col) && <span>🔑</span>}
              </div>
            ))}
          </div>
        )
      },
      style: { border: 'none', background: 'transparent', padding: 0 }
    }));
  }, [graphData]);

  const edges: Edge[] = useMemo(() => {
    if (!graphData) return [];
    return graphData.edges.map((e, i) => ({
      id: `e${i}`,
      source: e.source,
      target: e.target,
      animated: true,
      style: { stroke: '#818cf8', strokeWidth: 2 },
    }));
  }, [graphData]);

  if (!graphData) return <div className="p-4 text-center text-slate-500 text-sm">Loading schema...</div>;

  return (
    <motion.div 
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="h-[400px] w-full bg-slate-950 rounded-2xl border border-slate-800 overflow-hidden"
    >
      <ReactFlow nodes={nodes} edges={edges} fitView attributionPosition="bottom-right">
        <Background color="#334155" gap={20} size={1} />
        <Controls className="bg-slate-800 fill-white" />
      </ReactFlow>
    </motion.div>
  );
}