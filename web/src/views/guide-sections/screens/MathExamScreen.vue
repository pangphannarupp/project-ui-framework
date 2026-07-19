<template>
  <div class="component-section">
    <h2>Math Examination Template</h2>
    <p>A template for rendering formal mathematical examination papers using <code>BizMathPreview</code> for crisp LaTeX rendering.</p>

    <div class="demo-box template-demo">
      <div class="exam-scratchpad">
        <h3>Math Equation Builder</h3>
        <p>Use this editor to build and copy LaTeX equations.</p>
        <BizMathEditor v-model="fullExamLatex" />
      </div>

      <div class="exam-paper">
        <BizMathPreview :equation="fullExamLatex" :displayMode="true" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { BizMathPreview, BizMathEditor } from '@phanna/ui-framework';

const scratchpadLatex = ref('\\frac{x^2 + y^2}{2} = z');
const fullExamLatex = ref(`
\\begin{array}{l}
\\text{\\Large ប្រឡងជ្រើសរើសសិស្សពូកែ គណិតវិទ្យា រូបវិទ្យានិង} \\\\[0.2em]
\\text{\\Large អក្សរសិល្ប៍ខ្មែរ ថ្នាក់ទី៩ និងទី១២ ប្រចាំរាជធានីភ្នំពេញ} \\\\[1em]
\\text{\\large សម័យប្រឡង ២០ កុម្ភៈ ឆ្នាំ២០២០} \\\\[0.5em]
\\text{\\large វិញ្ញាសាទី១៖ គណិតវិទ្យាទី១២ សម្រាប់ថ្ងៃទី១ (២០-០២-២០)} \\\\[0.5em]
\\text{(រយៈពេល ៣ ម៉ោង)} \\\\[2em]
\\text{១. (៥ពិន្ទុ) រកចំនួនតួចែកវិជ្ជមាននៃចំនួន } A = [2019^3 + 3(2019 \\times 2020) + 1]^2 \\text{ ។} \\\\[1.5em]
\\text{២. (៥ពិន្ទុ) តាង } x = 1 + \\sqrt[3]{2} + \\sqrt[3]{4} + \\sqrt[3]{8} + \\sqrt[3]{16} + \\sqrt[3]{32} \\text{ ។ រកតម្លៃនៃ } B = \\left(1 + \\frac{1}{x}\\right)^{30} \\text{ ។} \\\\[1.5em]
\\text{៣. (១០ពិន្ទុ) តាង } a_1, a_2, a_3, ... \\text{ ជាស្វីតនៃចំនួនពិត ដែល } a_1 = 2 \\text{ និងចំពោះ } n \\geq 1 \\\\[0.5em]
a_{n+1} = \\frac{1+a_n}{1-a_n} \\text{ ។ កំណត់ } a_{2020} \\text{ ។} \\\\[1.5em]
\\text{៤. (១០ពិន្ទុ) រកតម្លៃធំបំផុត និងតម្លៃតូចបំផុតនៃ } y = \\frac{3x^2 + 2x + 2}{x^2 + 2x + 2} \\text{ ។} \\\\[1.5em]
\\text{៥. (១០ពិន្ទុ) រកសមីការដឺក្រេទី២ ដែលមានមេគុណជាចំនួនគត់ ហើយមានឫស} \\\\[0.5em]
\\cos 72^\\circ \\text{ និង } \\cos 144^\\circ \\text{ ។} \\\\[1.5em]
\\text{៦. (១៥ពិន្ទុ) ដោយមិនប្រើម៉ាស៊ីនគិតលេខ គណនា} \\\\[0.5em]
P = \\frac{1}{\\cos^2 10^\\circ} + \\frac{1}{\\sin^2 20^\\circ} + \\frac{1}{\\sin^2 40^\\circ} - \\frac{1}{\\cos^2 45^\\circ} \\\\[1.5em]
\\text{៧. (១៥ពិន្ទុ) ប្រៀបធៀប } S_n = \\sum_{k=1}^{n} \\frac{k}{(2n-2k+1)(2n-k+1)} \\text{ និង } T_n = \\sum_{k=1}^{n} \\frac{1}{k} \\text{ ។} \\\\[1.5em]
\\text{៨. (១៥ពិន្ទុ) ស្រាយបញ្ជាក់ថា } \\sqrt[3]{\\frac{2}{1}} + \\sqrt[3]{\\frac{3}{2}} + ... + \\sqrt[3]{\\frac{1011}{1010}} - \\frac{2019}{2} < \\frac{1}{3} + \\frac{1}{6} + \\frac{1}{9} + ... + \\frac{1}{9096}
\\end{array}
`);
</script>

<style scoped>
.template-demo {
  padding: 24px 0;
  background: #f3f4f6;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.exam-scratchpad {
  width: 100%;
  max-width: 800px;
  background: white;
  padding: 24px;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  margin-bottom: 24px;
}

.exam-scratchpad h3 {
  margin: 0 0 4px 0;
  font-size: 16px;
  color: #111827;
}

.exam-scratchpad p {
  margin: 0 0 16px 0;
  font-size: 14px;
  color: #6b7280;
}

.exam-paper {
  background: white;
  width: 100%;
  max-width: 800px;
  min-height: 1000px;
  padding: 60px 48px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  font-family: 'Khmer OS Battambang', 'Suwannaphum', sans-serif;
  color: #111827;
}

:deep(.katex-display) {
  margin: 0;
  text-align: left;
}

:deep(.katex) {
  font-size: 1.15em;
}
</style>
