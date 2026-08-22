import { EVStation } from '../types/ev'

export const EV_STATIONS: EVStation[] = [
  {
    id: 'ev-1',
    name: 'TotalEnergies Supercharger Hub',
    network: 'TotalEnergies EV',
    address: 'Monivong Blvd, Boeung Keng Kang',
    availablePorts: 3,
    totalPorts: 4,
    speedKw: 120,
    pricePerKwh: 0.28,
    connectorTypes: ['CCS2 Fast DC', 'Type 2 AC'],
    status: 'AVAILABLE'
  },
  {
    id: 'ev-2',
    name: 'PTT Station Chroy Changvar Hub',
    network: 'EV Station PluZ',
    address: 'National Road 6A, Chroy Changvar',
    availablePorts: 2,
    totalPorts: 2,
    speedKw: 60,
    pricePerKwh: 0.25,
    connectorTypes: ['CCS2', 'CHAdeMO'],
    status: 'AVAILABLE'
  },
  {
    id: 'ev-3',
    name: 'Aeon Mall Meanchey Super Hub',
    network: 'Charge+ Cambodia',
    address: 'Hun Sen Blvd, Chak Angre',
    availablePorts: 6,
    totalPorts: 8,
    speedKw: 160,
    pricePerKwh: 0.30,
    connectorTypes: ['Ultra Fast CCS2', 'GB/T'],
    status: 'AVAILABLE'
  }
]
