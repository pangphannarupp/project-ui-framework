import React from 'react';
import { CheckCircle2, XCircle } from 'lucide-react';

interface PaymentAlertProps {
  isOpen: boolean;
  type: 'success' | 'failed';
  title: string;
  message: string;
  confirmText?: string;
  onConfirm: () => void;
}

export const PaymentAlert: React.FC<PaymentAlertProps> = ({
  isOpen,
  type,
  title,
  message,
  confirmText = 'OK',
  onConfirm
}) => {
  if (!isOpen) return null;

  return (
    <div
      style={{
        position: 'fixed',
        inset: 0,
        backgroundColor: 'rgba(0, 0, 0, 0.75)',
        backdropFilter: 'blur(8px)',
        zIndex: 200,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '1.5rem',
        animation: 'fadeIn 0.2s ease-out'
      }}
      onClick={onConfirm}
    >
      <div
        style={{
          backgroundColor: '#151f32',
          border: '1px solid rgba(255, 255, 255, 0.1)',
          borderRadius: '20px',
          width: '100%',
          maxWidth: '380px',
          padding: '1.75rem 1.25rem',
          textAlign: 'center',
          boxShadow: '0 20px 50px rgba(0, 0, 0, 0.6)',
          animation: 'scaleUp 0.25s cubic-bezier(0.16, 1, 0.3, 1)'
        }}
        onClick={e => e.stopPropagation()}
      >
        {/* Icon */}
        <div
          style={{
            width: '64px',
            height: '64px',
            borderRadius: '50%',
            backgroundColor: type === 'success' ? 'rgba(16, 185, 129, 0.15)' : 'rgba(239, 68, 68, 0.15)',
            color: type === 'success' ? '#10b981' : '#ef4444',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            margin: '0 auto 1.25rem'
          }}
        >
          {type === 'success' ? <CheckCircle2 size={36} strokeWidth={2.5} /> : <XCircle size={36} strokeWidth={2.5} />}
        </div>

        {/* Title */}
        <h3
          style={{
            fontSize: '1.25rem',
            fontWeight: 800,
            color: '#ffffff',
            marginBottom: '0.5rem'
          }}
        >
          {title}
        </h3>

        {/* Message */}
        <p
          style={{
            fontSize: '0.85rem',
            color: '#94a3b8',
            lineHeight: '1.5',
            whiteSpace: 'pre-line',
            marginBottom: '1.5rem'
          }}
        >
          {message}
        </p>

        {/* Confirm Button */}
        <button
          onClick={onConfirm}
          className="btn-primary"
          style={{
            width: '100%',
            padding: '0.75rem 1rem',
            backgroundColor: type === 'success' ? '#0284c7' : '#334155',
            borderColor: type === 'success' ? '#38bdf8' : 'transparent'
          }}
        >
          {confirmText}
        </button>
      </div>

      <style>{`
        @keyframes scaleUp {
          from { transform: scale(0.9); opacity: 0; }
          to { transform: scale(1); opacity: 1; }
        }
      `}</style>
    </div>
  );
};
